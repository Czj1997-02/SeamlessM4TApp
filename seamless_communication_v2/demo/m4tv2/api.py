#!/usr/bin/env python
# Copyright (c) Meta Platforms, Inc. and affiliates
# All rights reserved.
#
# This source code is licensed under the license found in the
# MIT_LICENSE file in the root directory of this source tree.

from __future__ import annotations

import os
import pathlib

import numpy as np
import torch
import torchaudio
from fairseq2.assets import InProcAssetMetadataProvider, asset_store
from huggingface_hub import snapshot_download
from seamless_communication.inference import Translator
# from seamless_communication.models.inference.translator import Translator
from flask import Flask,request
import datetime
import requests
import scipy


# 模型挂载
print(f"{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} Model mounting ……")

CHECKPOINTS_PATH = pathlib.Path(os.getenv("CHECKPOINTS_PATH", "/opt/seamless_communication_v2/models"))
if not CHECKPOINTS_PATH.exists():
    snapshot_download(repo_id="meta-private/M4Tv2", repo_type="model", local_dir=CHECKPOINTS_PATH)
asset_store.env_resolvers.clear()
asset_store.env_resolvers.append(lambda: "demo")
demo_metadata = [
    {
        "name": "seamlessM4T_v2_large@demo",
        "checkpoint": f"file://{CHECKPOINTS_PATH}/seamlessM4T_v2_large.pt",
        "char_tokenizer": f"file://{CHECKPOINTS_PATH}/spm_char_lang38_tc.model",
    },
    {
        "name": "vocoder_v2@demo",
        "checkpoint": f"file://{CHECKPOINTS_PATH}/vocoder_v2.pt",
    },
]
asset_store.metadata_providers.append(InProcAssetMetadataProvider(demo_metadata))

if torch.cuda.is_available():
    device = torch.device("cuda:0")
    dtype = torch.float16
else:
    device = torch.device("cpu")
    dtype = torch.float32

translator = Translator(
    model_name_or_card="seamlessM4T_v2_large",
    vocoder_name_or_card="vocoder_v2",
    device=device,
    dtype=dtype,
    apply_mintox=True,
)

print(f"{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} Model mounted completed!")

# # 模型挂载
# print(f"{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} Model mounting ……")
# device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
# translator = Translator(
#     model_name_or_card="seamlessM4T_large",
#     vocoder_name_or_card="vocoder_36langs",
#     device=device,
#     dtype=torch.float16 if "cuda" in device.type else torch.float32,
# )
# print(f"{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')} Model mounted completed!")

def transform(inType,inLang,inStr,outType,outLang):

    # 默认文本到文本
    task_name = "T2TT"
    if inType == 'text' and outType == 'text':
        task_name = "T2TT"
    elif inType == 'text' and outType == 'speech':
        task_name = "T2ST"
    elif inType == 'speech' and outType == 'text':
        task_name = "S2TT"
    elif inType == 'speech' and outType == 'speech':
        task_name = "S2ST"

    out_texts, out_audios = translator.predict(
        input = inStr,
        task_str = task_name,
        tgt_lang = outLang,
        src_lang = inLang
    )
    # 音频采样速率
    sample_rate = int(out_audios.sample_rate)
    # 传出文本
    out_text = str(out_texts[0])
    out_wav = out_audios.audio_wavs[0].cpu().detach().numpy()
    out_wav = (out_wav / np.max(np.abs(out_wav)) * 32767).astype(np.int16)

    resData = {}
    if task_name in ["S2ST", "T2ST"]:
        fileName = datetime.datetime.now().strftime('%Y%m%d_%H%M%S') + '.wav'
        scipy.io.wavfile.write('/opt/seamless_communication/media/out/' + fileName, rate=sample_rate, data=out_wav)
        resData['wav'] = 'http://127.0.0.1:8081/media/' + fileName
        resData['before'] = inStr
        resData['text'] = out_text
    else:
        resData['before'] = inStr
        resData['text'] = out_text
    return resData
    
# 实例化一个web服务对象
app = Flask(__name__)
# 构造一个接受post请求的响应
@app.route('/',methods=['POST'])
def postRequest():
    data = {}
    data['data'] = {'text':'Not Found!'}
    data['code'] = 404
    
    # 获取传入参数
    key      = request.form.get('key')
    postType = request.form.get('postType','text') # 可选url/path/file/text
    
    inType   = request.form.get('inType','text')
    inLang   = request.form.get('inLang','cmn')
    inStr    = request.form.get('inStr')

    outType  = request.form.get('outType','text')
    outLang  = request.form.get('outLang','eng')
    
    # 验证秘钥是否通过
    if key != "ab7d978a80a0b833c460e4cf456edd6b":
        data['data'] = {'text':'No permissions!'}
        data['code'] = 400
        return data
    
    # 如果上传文件
    if 'file' in request.files:
        file = request.files['file']
        if file.filename == '':
            data['data'] = {'text':'No file!'}
            data['code'] = 400
            return data
        file_extension = file.filename.split(".")[-1]
        # 如果传入类型没有特别指定为文本，则此时认为传入的是音频文件,音频限定格式为wav，或mp3
        if inType != 'text' and file_extension != 'wav' and file_extension!= 'WAV' and file_extension != 'mp3' and file_extension!= 'MP3':
            data['data'] = {'text':'No Voice!'}
            data['code'] = 400
            return data
        if inType == 'text' and file_extension != 'txt' and file_extension!= 'TXT':
            data['data'] = {'text':'No Text!'}
            data['code'] = 400
            return data

        # 指定文件保存地址
        fileName = '/opt/seamless_communication/media/' + datetime.datetime.now().strftime('%Y%m%d_%H%M%S') + '.' + file_extension
        # 保存文件
        file.save(fileName)
        # 把保存路径传给inStr
        inStr = fileName
    # 如果传入的是远程地址，则需要先下载到本地
    elif postType == 'url':
        file_extension = inStr.split(".")[-1]
        # 如果传入类型没有特别指定为文本，则此时认为传入的是音频文件,音频限定格式为wav，或mp3
        if inType != 'text' and file_extension != 'wav' and file_extension!= 'WAV' and file_extension != 'mp3' and file_extension!= 'MP3':
            data['data'] = {'text':'No Voice!'}
            data['code'] = 400
            return data
        if inType == 'text' and file_extension != 'txt' and file_extension!= 'TXT':
            data['data'] = {'text':'No Text!'}
            data['code'] = 400
            return data

        # 指定文件保存地址
        fileName = '/opt/seamless_communication/media/' + datetime.datetime.now().strftime('%Y%m%d_%H%M%S') + '.' + file_extension
        # 保存文件
        downlaod(inStr, fileName)
        # 把保存路径传给inStr
        inStr = fileName
    # 如果传入的是本地地址，则可以直接使用
    elif postType == 'path':
        file_extension = inStr.split(".")[-1]
        # 如果传入类型没有特别指定为文本，则此时认为传入的是音频文件,音频限定格式为wav，或mp3
        if inType != 'text' and file_extension != 'wav' and file_extension!= 'WAV' and file_extension != 'mp3' and file_extension!= 'MP3':
            data['data'] = {'text':'No Voice!'}
            data['code'] = 400
            return data
        if inType == 'text' and file_extension != 'txt' and file_extension!= 'TXT':
            data['data'] = {'text':'No Text!'}
            data['code'] = 400
            return data
    # 如果不是以上，默认传入的是文本，则直接对文本进行操作
    else:
        data['inText'] = inStr
        data['data'] = transform('text',inLang,inStr,outType,outLang)
        data['outText'] = data['data']['text']
        data['code'] = 200
        return data
    
    # 如果是文件，则需要判断是不是需要读取的文件
    if inType == 'text':
        # 读取文本
        file = open(inStr,"r")
        inText = file.read()
        file.close()
        data['inText'] = inText
        # 获取结果
        data['data'] = transform('text',inLang,inText,outType,outLang)
        data['outText'] = data['data']['text']
        data['code'] = 200
        return data
    else:
        # 获取结果
        data['data'] = transform('speech',inLang,inStr,outType,outLang)
        data['outText'] = data['data']['text']
        data['code'] = 200
        return data
            
    return data
# 文件下载
def downlaod(url, file_path):
  headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Firefox/68.0"
  }
  r = requests.get(url=url, headers=headers)
  with open(file_path, "wb") as f:
    f.write(r.content)
    f.flush()

if __name__ == '__main__':
    # 运行服务，并确定服务运行的IP和端口
    app.run('0.0.0.0', '8080')