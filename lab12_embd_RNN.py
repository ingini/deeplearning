from keras.datasets import reuters
(train_data, train_labels), (test_data, test_labels) = reuters.load_data(num_words=10000)

from keras.layers import Embedding
from keras import preprocessing

print(print (train_data[0]) )
x_train = preprocessing.sequence.pad_sequences(train_data)
x_test = preprocessing.sequence.pad_sequences(test_data)
print (x_train[0])
########################################################################
from keras.utils import np_utils
y_train = np_utils.to_categorical(train_labels)

print('after embedding')
print('x_train', x_train)
print('y_train', y_train)
print('length of train_labels:', len(train_labels))

maxlen = 0
for element in x_train[0:]:
    if maxlen < len(element):
        maxlen = len(element)

print('maxlen: ', maxlen)

########################################################################
from keras.models import Sequential
from keras.layers import SimpleRNN, Dense

model = Sequential()
model.add(Embedding(10000, 8, input_length=maxlen))
# model.add(SimpleRNN(46, return_sequences=True ))
model.add(SimpleRNN(46))
model.add(Dense(46, activation="softmax"))
model.compile(optimizer='rmsprop', loss='categorical_crossentropy',
              metrics=['accuracy'])

####################################################################
import keras

callback_list = [
    keras.callbacks.EarlyStopping( #성능 향상이 멈추면 훈련을 중지
         monitor='val_acc',  #모델 검증 정확도를 모니터링
         patience=1          #1 에포크 보다 더 길게(즉, 2에포크 동안 정확도가 향상되지 않으면 훈련 중지
    ),
    keras.callbacks.ModelCheckpoint ( #에포크마다 현재 가중치를 저장
        filepath="RNN_model_h5",   #모델 파일 경로
        monitor="val_loss",    # val_loss 가 좋아지지 않으면 모델 파일을 덮어쓰지 않음.
        save_best_only=True
    )
]

import os
from keras.models import load_model
if os.path.exists("RNN_model_h5") :
    model =load_model( "RNN_model_h5")

history = model.fit(x_train,
                    y_train,
                    epochs=20,
                    callbacks=callback_list ,
                    batch_size=64,
                    validation_split=0.2)


