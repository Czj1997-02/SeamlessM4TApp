## SeamlessM4T

[SeamlessM4T](https://github.com/facebookresearch/seamless_communication)是Meta发布的一款能够转录和翻译近100种语言的一体化AI大模型。可以到[官方演示地址](https://seamless.metademolab.com/)进行体验。

## 本地部署
### 一、拉取项目
```
# 指定项目地址
cd /opt
# 拉取项目
git clone https://github.com/facebookresearch/seamless_communication.git
```
### 二、安装依赖
```
# 创建虚拟环境
mkvirtualenv -p python3 seamless
# 安装依赖
cd /opt/seamless_communication
pip install .
```
### 三、获取模型
在项目的`seamless_communication\src\seamless_communication\assets\cards`文件路径下
```
seamlessM4T_large.yaml
seamlessM4T_medium.yaml
unity_nllb-100.yaml
unity_nllb-200.yaml
vocoder_36langs.yaml
xlsr2_1b_v2.yaml
```
写有对应的模型资源地址：
```
checkpoint: "https://huggingface.co/facebook/seamless-m4t-large/resolve/main/multitask_unity_large.pt"
checkpoint: "https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/multitask_unity_medium.pt"
tokenizer: "https://huggingface.co/facebook/seamless-m4t-large/resolve/main/tokenizer.model"
tokenizer: "https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/tokenizer.model"
checkpoint: "https://huggingface.co/facebook/seamless-m4t-vocoder/resolve/main/vocoder_36langs.pt"
checkpoint: "https://dl.fbaipublicfiles.com/seamlessM4T/models/unit_extraction/xlsr2_1b_v2.pt"
```
将对应的模型资源下载到本地对应位置后，修改配置内的地址
```
checkpoint: "file://opt/seamless_communication/models/large/multitask_unity_large.pt"
checkpoint: "file://opt/seamless_communication/models/medium/multitask_unity_medium.pt"
tokenizer: "file://opt/seamless_communication/models/large/tokenizer.model"
tokenizer: "file://opt/seamless_communication/models/medium/tokenizer.model"
checkpoint: "file://opt/seamless_communication/models/vocoder/vocoder_36langs.pt"
checkpoint: "file://opt/seamless_communication/models/xlsr2/xlsr2_1b_v2.pt"
```
### 四、修改依赖
将官方demo文件夹内的依赖文件`/seamless_communication/demo/requirements.txt`中的
```
git+https://github.com/facebookresearch/seamless_communication
```
修改为使用本地安装（因为更换了模型资源地址为本地）
```
/opt/seamless_communication
```
再执行依赖安装
```
cd /opt/seamless_communication/demo
workon seamless
pip install -r requirements.txt
```
如果事先执行过使用远程依赖安装的，则需要先卸载远程版本依赖
```
pip uninstall seamless_communication
```
再安装本地版本依赖
```
pip install /opt/seamless_communication
```

### 五、异常处理
官方demo中有一段代码是用于获取远程音频资源，在国内由于网络问题可能无法获取
```
# Download sample input audio files
filenames = ["assets/sample_input.mp3", "assets/sample_input_2.mp3"]
for filename in filenames:
    hf_hub_download(
        repo_id="facebook/seamless_m4t",
        repo_type="space",
        filename=filename,
        local_dir=".",
    )
```
可以手动在[官方案例](https://huggingface.co/spaces/facebook/seamless_m4t/tree/main)下载后，将sample_input.mp3、sample_input_2.mp3放到对应目录`/opt/seamless_communication/demo/assets`
并注释掉如上代码片段
### 六、运行Demo
```
workon seamless
cd /opt/seamless_communication/demo
python app.py
```
就可以看到运行成功
```
Running on local URL:  http://127.0.0.1:7860
```

#### 6.1 修改启动端口
```
# 将
# demo.queue().launch()
# 修改成
demo.queue().launch(share=True, inbrowser=True, server_name='127.0.0.1', server_port=8080)
```
#### 6.2 Gradio无法构建可访问链接
##### 下载文件：
```
wget https://cdn-media.huggingface.co/frpc-gradio-0.2/frpc_linux_amd64
```
##### 重命名下载的文件：
```
mv frpc_linux_amd64 frpc_linux_amd64_v0.2
```
##### 将文件移动到指定位置：
```
mv frpc_linux_amd64_v0.2 /root/.virtualenvs/glm/lib/python3.8/site-packages/gradio
```
##### 找到文件
```
cd /root/.virtualenvs/glm/lib/python3.8/site-packages/gradio
```
##### 授予权限
```
chmod 777 frpc_linux_amd64_v0.2
```

#### 6.3 异常处理
```
Traceback (most recent call last):
  File "app.py", line 587, in <module>
    input_audio_mic = gr.Audio(
  File "/root/.virtualenvs/seamless/lib/python3.8/site-packages/gradio/component_meta.py", line 152, in wrapper
    return fn(self, **kwargs)
TypeError: __init__() got an unexpected keyword argument 'source'
```
注释掉
```
# source="microphone",
# source="upload",
```

#### 七、使用Flask自定义接口

在demo同级目录下，创建有Flask接口文件`seamless_communication\demo\api.py`，跳转到对应目录后，执行`python api.py`即可

|接口|`http://127.0.0.1:8080`|||
|---|---|---|---|
|类型|`POST`|`body`中使用 `form-data` 上传||
|`key`|必填秘钥|`ab7d978a80a0b833c460e4cf456edd6b`||
|`postType`|传入类型|`url` `path` `file` `text` |默认 `text`|
|`inType`|输入类型|`text` `speech` |默认 `text`|
|`inLang`|输入语种||默认中文 `cmn`|
|`inStr`|输入文本|被译文本、远程/本地文件地址|仅上传文件时可不填|
|`outType`|输出类型|`text` `speech` |默认 `text`|
|`outLang`|输出语种||默认英语 `eng`|
|`file`|上传文件|`wav` `mp3` `txt`||

##### 7.1 特殊说明

因为生成的语音文件，默认保存到本地服务器的指定文件夹内，需要使用Nginx配置将该文件夹设置允许访问

```
vi /etc/nginx/nginx.conf
```

```
http {
    # 加入如下内容
	server {
		listen       8081;
		server_name  localhost;
		location /media/ {
			alias /opt/seamless_communication/media/out/;
			autoindex on;
		}
	}


}
```

```
service nginx restart
sudo chmod -R 755 /opt/seamless_communication/media/out/
```


#### 八、 Flutter App

<img src="https://gitee.com/CZJpython/SeamlessM4T-APP/raw/master/static/Screenshot_2023-11-27-10-08-25-252_comhundunseamless_1701050964.jpg" width="150" >
<img src="https://gitee.com/CZJpython/SeamlessM4T-APP/raw/master/static/Screenshot_2023-11-27-10-07-14-905_comhundunseamless_1701050940.jpg" width="150" >
<img src="https://gitee.com/CZJpython/SeamlessM4T-APP/raw/master/static/Screenshot_2023-11-27-10-07-19-337_comhundunseamless_1701050947.jpg" width="150" >
<img src="https://gitee.com/CZJpython/SeamlessM4T-APP/raw/master/static/Screenshot_2023-11-27-10-08-17-706_comhundunseamless_1701050956.jpg" width="150" >
