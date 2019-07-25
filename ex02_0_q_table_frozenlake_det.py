import gym
import numpy as np
import matplotlib.pyplot as plt
from gym.envs.registration import register
import random

#최대값이 모두 같을 때 random하게 return하도록 작성한 코드.  
def rargmax(vector):     
    m = np.max(vector)
    indices = np.nonzero(vector == m)[0]
    return random.choice(indices)

register(
    id='FrozenLake-v3',
    entry_point='gym.envs.toy_text:FrozenLakeEnv',
    kwargs={'map_name' : '4x4', 'is_slippery': False}
)
env = gym.make('FrozenLake-v3')

# Q를 모두 0으로 초기화.  Q[16,4]
Q = #TODO ([env.observation_space.n, env.action_space.n])
num_episodes = 2000

# create lists to contain total rewards and steps per episode
rList = []
for i in range(num_episodes): # 여러번 반복 학습 
    state  #TODO  # 환경 reset 후, 첫번째 상태 얻음
    rAll = 0
    done = False

    # The Q-Table learning algorithm
    while not done:
        #현재 state의 Q중 최대 reward를 얻을 수 있는 action을 구함. 
        action =  #TODO

        # 환경에서 action 후, new_state와 reward를 얻음
        # action( 0 - left, 1 -douwn, 2-right, 3-up )
        new_state, reward, done, _ = #TODO
         
        # Q-Table 갱신
        # TODO

        rAll += reward
        state = new_state
    rList.append(rAll)

print("Success rate: " + str(sum(rList) / num_episodes))
print("Final Q-Table Values")
print("LEFT DOWN RIGHT UP")
print(Q)

plt.bar(range(len(rList)), rList, color="b", alpha=0.4)
plt.show()

 