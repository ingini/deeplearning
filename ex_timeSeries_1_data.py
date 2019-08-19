import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import toeplitz
np.random.seed(0)

def make_data( showGraph=False ) :
    rawdata = np.sin(2 * np.pi * 0.125 * np.arange(20))

    if  showGraph :
        print( "rawdata ", rawdata )
        plt.plot(rawdata, 'ro-')
        plt.xlim(-0.5, 20.5)
        plt.ylim(-1.1, 1.1)
        plt.show()

    """
    Keras 에서 RNN 을 사용하려면 입력 데이터는 
    (nb_samples, timesteps, input_dim) 크기를 가지는 
    ndim=3인 3차원 텐서(tensor) 형태이어야 한다.

    nb_samples: 자료의 수
    timesteps: 순서열의 길이
    input_dim: x 벡터의 크기
    여기에서는 단일 시계열이므로 input_dim = 1 이고 
    3 스텝 크기의 순서열을 사용하므로 timesteps = 3 이며 자료의 수는 18 개이다.

    다음코드와 같이 원래의 시계열 벡터를 Toeplitz 행렬 형태로 변환하여 3차원 텐서를 만든다.
    """

    Data = np.fliplr(toeplitz(np.r_[rawdata[-1], np.zeros(rawdata.shape[0] - 2)], rawdata[::-1]))
    # print("Data", Data)
    # print(Data.shape)

    X_train = Data[:-1, :3][:, :, np.newaxis]
    Y_train = Data[:-1, 3]
    print("X_train.shape, Y_train.shape  = ", X_train.shape, Y_train.shape )
    print("X_train[0], Y_train[0]  = ", X_train[0], Y_train[0])

    if showGraph:
        plt.subplot(211)
        plt.plot([0, 1, 2], X_train[0].flatten(), 'bo-', label="input sequence")
        plt.plot([3], Y_train[0], 'ro', label="target")
        plt.xlim(-0.5, 4.5)
        plt.ylim(-1.1, 1.1)
        plt.legend()
        plt.title("First sample sequence")


        plt.subplot(212)
        plt.plot([1, 2, 3], X_train[1].flatten(), 'bo-', label="input sequence")
        plt.plot([4], Y_train[1], 'ro', label="target")
        plt.xlim(-0.5, 4.5)
        plt.ylim(-1.1, 1.1)
        plt.legend()
        plt.title("Second sample sequence")
        plt.tight_layout()
        plt.show()

    return (X_train,Y_train)


if __name__ == '__main__':
    make_data(True)
