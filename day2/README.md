# iOS机器学习
1. [CoreML Day2 预习资料 ](./coreML.pdf)
什么是Machine Learning：机器学习是人工智能的一个分 ，它目的的在于吸收任何的数据比如说(图像、文本、语音、统计数据) 然后作出预测数据当中所隐藏的特征或是行为。也就是说通过吸收大量数据，找出其中的行为的一种工具；

[CNN(卷积神经网络)、RNN(循环神经网络)、DNN(深度神经网络)的内部网络结构有什么区别？](https://www.zhihu.com/question/34681168)

人工神经网络（ANN）：
人工神经网络（Artificial Neural Network，即ANN ），是20世纪80 年代以来人工智能领域兴起的研究热点。它从信息处理角度对人脑神经元网络进行抽象， 建立某种简单模型，按不同的连接方式组成不同的网络。在工程与学术界也常直接简称为神经网络或类神经网络。神经网络是一种运算模型，由大量的节点（或称神经元）之间相互联接构成。每个节点代表一种特定的输出函数，称为激励函数（activation function）。每两个节点间的连接都代表一个对于通过该连接信号的加权值，称之为权重，这相当于人工神经网络的记忆。网络的输出则依网络的连接方式，权重值和激励函数的不同而不同。而网络自身通常都是对自然界某种算法或者函数的逼近，也可能是对一种逻辑策略的表达。------百度百科
卷积神经网络（CNN）：


监督学习：
非监督学习：

# Core ML Tools
[coremltools](https://apple.github.io/coremltools/)
Core ML Tools is a python package that can be used to convert models from machine learning toolboxes into the Core ML format.
https://pypi.python.org/pypi/coremltools
coremltools is a python package for creating, examining, and testing models in the .mlmodel format. In particular, it can be used to:

* Convert existing models to .mlmodel format from popular machine learning tools including Keras, Caffe, scikit-learn, libsvm, and XGBoost.
* Express models in .mlmodel format through a simple API.
* Make predictions with an .mlmodel (on select platforms for testing purposes).
## Installation
```
pip install -U coremltools
```
## Dependencies

coremltools has the following dependencies:
* numpy (1.12.1+)
* protobuf (3.1.0+)
In addition, it has the following soft dependencies that are only needed when you are converting models of these formats:
* Keras (1.2.2, 2.0.4+) with Tensorflow (1.0.x, 1.1.x)
* Xgboost (0.6+)
* scikit-learn (0.15+)
* libSVM

