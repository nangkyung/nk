#!/usr/bin/env python
# coding: utf-8

# In[1]:


pip install tensorflow


# In[102]:


import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers


# In[103]:


import pathlib

import pandas as pd
import seaborn as sns


# In[104]:


obesity=pd.read_csv('FINAL_FIN.csv')


# In[105]:


obesity


# In[153]:


print(type(obesity))


# In[155]:


drop=obesity[obesity["BMI"]==0].index


# In[156]:


obesity2=obesity.drop(drop)


# In[157]:


obesity2


# In[158]:


train_dataset = obesity2.sample(frac=0.8,random_state=0)
train_dataset.shape


# In[159]:


test_dataset = obesity2.drop(train_dataset.index)
test_dataset.shape


# In[160]:


train_labels = train_dataset.pop("BMI")


# In[161]:


train_labels.shape


# In[162]:


test_labels = test_dataset.pop("BMI")


# In[163]:


test_labels.shape


# In[171]:


train_stats = train_dataset.describe()
train_stats = train_stats.transpose()


# In[172]:


def norm(x):
  return (x - train_stats['mean']) / train_stats['std']


# In[173]:


normed_train_data = norm(train_dataset)
normed_test_data = norm(test_dataset)


# In[174]:


normed_train_data


# In[175]:


def build_model():
  model = keras.Sequential([
    layers.Dense(64, activation='relu', input_shape=[len(train_dataset.keys())]),
    layers.Dense(64, activation='relu'),
    layers.Dense(1)
  ])

  optimizer = tf.keras.optimizers.RMSprop(0.001)

  model.compile(loss='mse',
                optimizer=optimizer,
                metrics=['mae', 'mse'])
  return model


# In[176]:


model = build_model()


# In[177]:


model.summary()


# In[178]:


class PrintDot(keras.callbacks.Callback):
  def on_epoch_end(self, epoch, logs):
    if epoch % 100 == 0: print('')
    print('.', end='')

EPOCHS = 100

history = model.fit(
  normed_train_data, train_labels,
  epochs=EPOCHS, validation_split = 0.2, verbose=0,
  callbacks=[PrintDot()])


# In[179]:


hist = pd.DataFrame(history.history)
hist['epoch'] = history.epoch
hist.tail()


# In[180]:


model.evaluate(test_dataset, test_labels)


# In[181]:


import matplotlib.pyplot as plt

def plot_history(history):
  hist = pd.DataFrame(history.history)
  hist['epoch'] = history.epoch

  plt.figure(figsize=(8,12))

  plt.subplot(2,1,1)
  plt.xlabel('Epoch')
  plt.ylabel('Mean Abs Error [BMI]')
  plt.plot(hist['epoch'], hist['mae'],
           label='Train Error')
  plt.plot(hist['epoch'], hist['val_mae'],
           label = 'Val Error')
  plt.ylim([0,5])
  plt.legend()

  plt.subplot(2,1,2)
  plt.xlabel('Epoch')
  plt.ylabel('Mean Square Error [$BMI^2$]')
  plt.plot(hist['epoch'], hist['mse'],
           label='Train Error')
  plt.plot(hist['epoch'], hist['val_mse'],
           label = 'Val Error')
  plt.ylim([0,20])
  plt.legend()
  plt.show()

plot_history(history)


# In[182]:


model = build_model()

early_stop = keras.callbacks.EarlyStopping(monitor='val_loss', patience=10)

history = model.fit(normed_train_data, train_labels, epochs=EPOCHS,
                    validation_split = 0.2, verbose=0, callbacks=[early_stop, PrintDot()])

plot_history(history)


# In[184]:


loss, mae, mse = model.evaluate(normed_test_data, test_labels, verbose=2)

print("테스트 세트의 평균 절대 오차: {:5.2f} bmi".format(mae))


# In[185]:


test_predictions = model.predict(normed_test_data).flatten()

plt.scatter(test_labels, test_predictions)
plt.xlabel('True Values [BMI]')
plt.ylabel('Predictions [BMI]')
plt.axis('equal')
plt.axis('square')
plt.xlim([0,plt.xlim()[1]])
plt.ylim([0,plt.ylim()[1]])
_ = plt.plot([-100, 100], [-100, 100])


# In[186]:


sns.scatterplot(x=test_labels, y=test_predictions)


# In[187]:


sns.jointplot(x=test_labels, y=test_predictions, kind="reg")


# In[ ]:




