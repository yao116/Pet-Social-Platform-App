#!/usr/bin/env python
# coding: utf-8

# In[221]:


import pandas as pd
import numpy as np
import random
import datetime
from pandas.tseries.offsets import DateOffset


# In[260]:


Pet = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/PET.csv")
User = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/User.csv")
Breeding_record = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/Breeding_record.csv")
Medical_history = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/Medical_History.csv")
Veterinary_company = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/Veterinary_Company.csv")
Purpose_of_visit = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/Purpose_of_visit.csv")


# In[257]:


final = Pet.merge(User, left_on = "User_ID", right_on = "User_ID")
final['Data_of_birth'] = pd.to_datetime(final['Data_of_birth'])
Breeding_record['Breeding_date'] = pd.to_datetime(Breeding_record['Breeding_date'])
Medical_history['Date_of_visit'] = pd.to_datetime(Medical_history['Date_of_visit'], format = '%Y-%m-%d')


# In[25]:


final


# In[38]:





# In[176]:


for index, row in Breeding_record.iterrows():
    timedif = (final['Data_of_birth'] - row.Breeding_date)/np.timedelta64(1,'D')
    temp = final.loc[timedif > 365]
    b = temp.sample(n = 1)
    row.Appearance_inherited_or_not = random.choice(['T', 'F'])
    if(b['Gender'].item() == 'F'):
        row.F_Pet_ID = b['Pet_ID']
    else:
        row.M_Pet_ID = b['Pet_ID']
    Breeding_record.loc[index] = row
print(Breeding_record)
Breeding_record.to_csv("/Users/nancy/Documents/COURSES/info257/finalproject/F_Breeding_record.csv",index = False)


# In[177]:


i = 0
for index, row in Medical_history.iterrows():
    i += 1
    timedif = (final['Data_of_birth'] - row.Date_of_visit)/np.timedelta64(1,'D')
    temp = final.loc[timedif > 30]
    a = temp.sample(n = 1)
    row.Pet_ID = a['Pet_ID']
    vettemp = Veterinary_company.loc[Veterinary_company['City'].values == a['City'].values]
#     print(a['City'])
    b = vettemp.sample(n = 1)
    row.Veterinary_ID = b['Veterinary_ID']
#     print(row.Pet_ID.values)
#     print(Medical_history['Pet_ID'].values)
    step1 = Medical_history.loc[Medical_history['Purpose_ID']== 101]
    step2 = step1.loc[step1['Pet_ID'].values == row.Pet_ID.values]
#     print(step2.empty)
#     print(type(timedif))
    if(timedif.all() < 90 
       | ~ step2.empty ):
        c = Purpose_of_visit[1:].sample(n = 1)
    else:
        c = Purpose_of_visit.sample(n = 1)
    row.Purpose_ID = c['Purpose_ID']
    Medical_history.loc[index] = row
print(Medical_history)
Medical_history.to_csv("/Users/nancy/Documents/COURSES/info257/finalproject/F_Medical_history.csv", index = False)


# In[261]:


Foster_care_record = pd.read_csv("/Users/nancy/Documents/COURSES/info257/finalproject/Foster_care_record.csv")


# In[262]:


Foster_care_record.head()


# In[263]:


Foster_care_record['Date_of_travle'] = pd.to_datetime(Foster_care_record['Date_of_travle'])
Foster_care_record['Request_date'] = pd.to_datetime(Foster_care_record['Request_date'])
Foster_care_record['Date_of_return'] = pd.to_datetime(Foster_care_record['Date_of_return'])
Foster_care_record.dtypes


# In[266]:


for index, row in Foster_care_record.iterrows():
    pettemp = final.loc[~final.City.isin(['Phonenix','West Lafayette','Austin','San Antonio'])]
    a = pettemp.sample(n = 1)
#     print(final['User_ID'].values != a['User_ID'].values)
#     print(type(User['City']))
#     print(type(a))
    row.Pet_ID = a['Pet_ID']
    usertemp = final.loc[(final['City'].values == a['City'].values) 
                        & (final['User_ID'].values != a['User_ID'].values)]
#     print(usertemp)
    b = usertemp.sample(n = 1)
    row.User_ID = b['User_ID']
    rd1 = random.randint(30, 999)
    rd2 = random.randint(1, 100)
    rd3 = random.randint(1, 100)
    row.Date_of_travle = a['Data_of_birth'] + datetime.timedelta(days=rd1)
#     print(row.Date_of_travle - datetime.timedelta(days = rd2))
    row.Request_date = row.Date_of_travle - datetime.timedelta(days = rd2)
#     print(a['Data_of_birth'])
#     print(row.Date_of_travle)
#     print(row.Request_date)
    row.Date_of_return = row.Date_of_travle + datetime.timedelta(days = rd3)
    Foster_care_record.loc[index] = row
# print (Foster_care_record)
Foster_care_record.to_csv("/Users/nancy/Documents/COURSES/info257/finalproject/F_Foster_care_record.csv", index = False)


# In[ ]:





# In[ ]:





# In[ ]:




