from keras.models import Sequential
from keras.layers import SimpleRNN, Dense

#################################################################
"""
SimpleRNN 클래스 생성시 return_sequences 인수를 True로 하면 출력 순서열 중
마지막 값만 출력하는 것이 아니라 전체 순서열을 3차원 텐서 형태로 출력하므로 
sequence-to-sequence 문제로 풀 수 있다. 다만 입력 순서열과 출력 순서열의 크기는 같아야 한다.
다만 이 경우에는 다음에 오는 Dense 클래스 객체를 
TimeDistributed wrapper를 사용하여 3차원 텐서 입력을 받을 수 있게 확장해 주어야 한다.
"""
from keras.layers import TimeDistributed

def make_model() :
    model2 = Sequential()
    model2.add(SimpleRNN(10, return_sequences=True, input_shape(3,1)))
    model2.add(TimeDistributed(Dense (1, activation="linear")))  ####
    model2.compile(loss='mse', optimizer='sgd')
    model2.summary()
    return model2