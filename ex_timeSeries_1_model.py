
"""
우선 가장 단순한 신경망 구조인 SimpleRNN 클래스를 사용하는 방법은 다음 코드와 같다.
여기에서는 SimpleRNN 클래스 객체로 10개의 뉴런을 가지는 RNN 층을 만든다. 
첫번째 인수로는 뉴런의 크기, 
input_dim 인수로는 벡터의 크기, 
input_length 인수로는 순서열으 길이를 입력한다.
그 다음으로 SimpleRNN 클래스 객체에서 나오는 10개의 출력값을 
하나로 묶어 실수 값을 출력으로 만들기 위해 Dense 클래스 객체를 추가하였다.
손실 함수로는 mean-squred-error를, 최적화 방법으로는 
단순한 stochastic gradient descent 방법을 사용한다.
"""

from keras.models import Sequential
from keras.layers import SimpleRNN, Dense


def make_model() :
    model = Sequential()
    model.add(SimpleRNN(10,input_shape=(3,1))) 
    model.add( Dense(1)  )  #, activation="linear"
    model.compile( loss='mse' , optimizer='sgd')
    model.summary()
    return model
