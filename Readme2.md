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
最好修改项目文件夹名为`seamless_communication_v2`，因为我后面是这样的，如果不一样的话你需要自己去改动其他相关内容


### 二、修改资源地址

因为不想把模型文件移来移去，所以版本一相关的模型文件在`/opt/seamless_communication/models`文件夹内，这也是为啥要求新拉取项目更名为`seamless_communication_v2`的原因，或者直接使用我这个项目内改好的项目包

找到`/opt/seamless_communication_v2/src/seamless_communication/cards`文件夹内的配置文件，下载资源放在对应位置`/opt/seamless_communication_v2/models/`后，将对应内容修改如下：
```
# uri: "https://dl.fbaipublicfiles.com/seamless/datasets/mexpresso_text/mexpresso_text.tar"
uri: "file://opt/seamless_communication_v2/models/mexpresso_text.tar"

# sp_model: https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/tokenizer.model
sp_model: http://127.0.0.1:8081/models/tokenizer.model

# char_tokenizer: "https://huggingface.co/facebook/seamless-streaming/resolve/main/spm_char_lang38_tc.model"
char_tokenizer: "file://opt/seamless_communication_v2/models/spm_char_lang38_tc.model"

# checkpoint: "https://dl.fbaipublicfiles.com/seamless/models/unity2_aligner.pt"
checkpoint: "file://opt/seamless_communication_v2/models/unity2_aligner.pt"

# char_tokenizer: "https://huggingface.co/facebook/seamless-streaming/resolve/main/spm_char_lang38_tc.model"
char_tokenizer: "file://opt/seamless_communication_v2/models/spm_char_lang38_tc.model"

# checkpoint: "https://huggingface.co/facebook/seamless-streaming/resolve/main/seamless_streaming_monotonic_decoder.pt"
checkpoint: "file://opt/seamless_communication_v2/models/seamless_streaming_monotonic_decoder.pt"

# char_tokenizer: "https://huggingface.co/facebook/seamless-streaming/resolve/main/spm_char_lang38_tc.model"
char_tokenizer: "file://opt/seamless_communication_v2/models/spm_char_lang38_tc.model"

# checkpoint: "https://huggingface.co/facebook/seamless-streaming/resolve/main/seamless_streaming_unity.pt"
checkpoint: "file://opt/seamless_communication_v2/models/seamless_streaming_unity.pt"

# checkpoint: "https://huggingface.co/facebook/seamless-m4t-large/resolve/main/multitask_unity_large.pt"
checkpoint: "file://opt/seamless_communication/models/large/multitask_unity_large.pt"

# checkpoint: "https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/multitask_unity_medium.pt"
checkpoint: "file://opt/seamless_communication/models/medium/multitask_unity_medium.pt"

# char_tokenizer: "https://huggingface.co/facebook/seamless-m4t-v2-large/resolve/main/spm_char_lang38_tc.model"
char_tokenizer: "file://opt/seamless_communication_v2/models/v2/spm_char_lang38_tc.model"

# checkpoint: "https://huggingface.co/facebook/seamless-m4t-v2-large/resolve/main/seamlessM4T_v2_large.pt"
checkpoint: "file://opt/seamless_communication_v2/models/seamlessM4T_v2_large.pt"

# tokenizer: "https://huggingface.co/facebook/seamless-m4t-large/resolve/main/tokenizer.model"
tokenizer: "/opt/seamless_communication/models/large/tokenizer.model"

# tokenizer: "https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/tokenizer.model"
tokenizer: "/opt/seamless_communication/models/medium/tokenizer.model"

# checkpoint: "https://huggingface.co/facebook/seamless-m4t-vocoder/resolve/main/vocoder_36langs.pt"
checkpoint: "file://opt/seamless_communication/models/vocoder/vocoder_36langs.pt"

# checkpoint: "https://dl.fbaipublicfiles.com/seamless/models/vocoder_v2.pt"
checkpoint: "file://opt/seamless_communication_v2/models/vocoder_v2.pt"

# checkpoint: "https://dl.fbaipublicfiles.com/seamlessM4T/models/unit_extraction/xlsr2_1b_v2.pt"
checkpoint: "file://opt/seamless_communication_v2/models/xlsr2_1b_v2.pt"
```

**需要特殊说明**

```
# sp_model: https://huggingface.co/facebook/seamless-m4t-medium/resolve/main/tokenizer.model
sp_model: http://127.0.0.1:8081/models/tokenizer.model
```
这个配置原链接拉取不到，改成本地无效，可以把文件放在一个可访问的网站，比如网盘，获取可直接下载的链接后改写替换这个地址

### 三、安装依赖
```
# 创建虚拟环境
mkvirtualenv -p python3 seamless
workon seamless
# 安装依赖
cd /opt/seamless_communication
pip install .
cd /opt/seamless_communication_v2/demo/m4tv2
pip install -r requirements.txt
pip uninstall seamless_communication
pip install /opt/seamless_communication_v2
```

### 四、执行文件
官方案例：
```
workon seamless
cd /opt/seamless_communication_v2/demo/m4tv2
python app.py
```
自定义接口：
```
workon seamless
cd /opt/seamless_communication_v2/demo/m4tv2
python api.py
```

