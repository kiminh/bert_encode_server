## Bert Encode Server

### 更新

**2020-01-11** 修复BERT模型加载出现`AttributeError: 'BertConfig' object has no attribute 'embedding_size'`的错误，原因是对开启server的参数`-albert`进行处理时出现错误；现在，`-albert`参数被设置为`store_true`的动作参数，默认为`False`。

### 简介

**项目在肖涵老师的[bert-as-service](https://github.com/hanxiao/bert-as-service)上添加了albert模型，总体来说该项目的使用与bert-as-service保持一致。**

**直接通过Bert Encode Server服务端获取输入特征（可以是字特征，也可以是句特征），此时的预训练语言模型仅作为特征提取器，是一个通用的frozen模型，不参与下游模型的训练，可以显著降低下游模型的空间复杂性；从Bert Encode Server服务端提取特征需要一定的耗时，但该耗时并不显著。**

**2020-01-11** 加载roberta系列模型时，不需要添加`-albert`参数，其网络结构与bert模型一致。 

### 字特征提取（服务端）

```bash
cd char_server
./char_server.sh
```

注意修改`.char_server.sh`中文件的相关内容：

1. 如果使用`ALBERT`模型，应添加参数`-albert`；
2. `model_dir`，`ckpt_name`和`config_name`根据预训练语言模型的位置进行相应调整；
3. 如使用`cpu`，添加`-cpu`参数；如使用`gpu`，添加`-device_map "0"`，其中`"0"`为0号gpu。

### 句特征提取（服务端）

```bash
cd sent_server
./sent_server.sh
```

参数与**字特征提取（服务端）**所示参数一致，但需注意：`-pooling_strategy`参数应删除或设置该参数为`REDUCE_MEAN`。

### 使用客户端

```python
import requests

r = requests.post(
    "http://your_ip:your_port/encode",
    json={
        "id": 123,
        "texts": ["啊","啥意思"],
        "is_tokenized": False
    }
)
```

其中，`json`的`texts`字段为**句list**时，`is_tokenized`字段为`False`；`texts`字段为**分字list**时，`is_tokenized`字段为`True`。

### 常用中文预训练语言模型下载地址

**BERT**

Google_bert：https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip

HIT_bert_wwm_ext：https://storage.googleapis.com/chineseglue/pretrain_models/chinese_wwm_ext_L-12_H-768_A-12.zip

**ALBERT**

Google_albert_base：https://storage.googleapis.com/albert_models/albert_base_zh.tar.gz

Google_albert_large：https://storage.googleapis.com/albert_models/albert_large_zh.tar.gz

Google_albert_xlarge：https://storage.googleapis.com/albert_models/albert_xlarge_zh.tar.gz

Google_albert_xxlarge：https://storage.googleapis.com/albert_models/albert_xxlarge_zh.tar.gz

Xuliang_albert_xlarge：https://storage.googleapis.com/albert_zh/albert_xlarge_zh_177k.zip

Xuliang_albert_large：https://storage.googleapis.com/albert_zh/albert_large_zh.zip

Xuliang_albert_base：https://storage.googleapis.com/albert_zh/albert_base_zh.zip

Xuliang_albert_base_ext：https://storage.googleapis.com/albert_zh/albert_base_zh_additional_36k_steps.zip

Xuliang_albert_small：https://storage.googleapis.com/albert_zh/albert_small_zh_google.zip

Xuliang_albert_tiny：https://storage.googleapis.com/albert_zh/albert_tiny_zh_google.zip

**Roberta**

roberta：https://storage.googleapis.com/chineseglue/pretrain_models/roeberta_zh_L-24_H-1024_A-16.zip

roberta_wwm_ext：https://storage.googleapis.com/chineseglue/pretrain_models/chinese_roberta_wwm_ext_L-12_H-768_A-12.zip

roberta_wwm_ext_large：https://storage.googleapis.com/chineseglue/pretrain_models/chinese_roberta_wwm_large_ext_L-24_H-1024_A-16.zip