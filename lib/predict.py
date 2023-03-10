from datetime import datetime
from flask import Flask,request,jsonify
from keras.preprocessing.sequence import TimeseriesGenerator


app = Flask(__name__)

@app.route('/api',methods=['GET'])

def hello_world():

	import pandas as pd
	import numpy as np  # linear algebra
	import tensorflow as tf
	import yfinance as yf
	from keras.preprocessing.sequence import TimeseriesGenerator
	from keras.models import load_model

	# ----- รับข้อมูลจากหน้า web ---------
	d = {}
	d['Soybean_meal_US'] = float(request.args['Soybean_meal_US'])
	d['Crude_Oil'] = float(request.args['Crude_Oil'])
	d['New_Month'] = float(request.args['New_Month'])
	d['Year'] = float(request.args['Year'])

	df_input = pd.DataFrame([d]) #แปลงเป็น dataframe
	# print(df_input.dtypes)
	# d['Soybean_meal_US'] = d['Soybean_meal_US'].astype(float)
	year = int(d['Year'])
	month = int(d['New_Month'] )
	day = 1
	print('year')
	print(year-543)

	if month == 1:
		start_date = datetime(year - 544, 10, day)  # 12 11 10
		end_date = datetime(year - 543, month, day)
	elif month == 2:
		start_date = datetime(year - 544, 11, day)  # 1 12 11
		end_date = datetime(year - 543, month, day)
	elif month == 3:
		start_date = datetime(year - 544, 12, day)  # 2 1 12
		end_date = datetime(year - 543, month, day)
	else:
		start_date = datetime(year - 543, month - 3, day)
		end_date = datetime(year - 543, month, day)

	print(end_date)
	print(start_date)

	#------- อ่านข้อมูล excel  ---------
	df_crude_oil_data = pd.read_excel('crude_oil_data.xls')  # soybean_meal_data.xls
	df_soybean_meal_data = pd.read_excel('soybean_meal_data.xls')  # soybean_meal_data.xls

	#------- ทำ excel to array --------
	array_crude_oil_data = df_crude_oil_data.to_numpy()
	array_soybean_meal_data = df_soybean_meal_data.to_numpy()

	#-------- ดึงข้อมูลที่ต้องการจาก array ไปใส่อีก array ----------
	new_crude_oil = []
	for i in range(len(array_crude_oil_data)):
		new_crude_oil.append([])
		for j in range(1, 3):
			if array_crude_oil_data[i][1] >= start_date and array_crude_oil_data[i][1] < end_date:
				new_crude_oil[i].append(array_crude_oil_data[i][j])
				print(array_crude_oil_data[i][j])

	new_soybean_meal = []
	for i in range(len(array_soybean_meal_data)):
		new_soybean_meal.append([])
		for j in range(1, 3):
			if array_soybean_meal_data[i][1] >= start_date and array_soybean_meal_data[i][1] < end_date:
				new_soybean_meal[i].append(array_soybean_meal_data[i][j])
				print(array_soybean_meal_data[i][j])

	#ทำ new array to dataframe and drop all Nan or NaT
	soybean_meal_complete = pd.DataFrame(new_soybean_meal, columns=['Date', 'Soybean_meal_us'])
	soybean_meal_complete = soybean_meal_complete.dropna()
	crude_oil_complete = pd.DataFrame(new_crude_oil, columns=['Date', 'Crude_Oil'])
	crude_oil_complete = crude_oil_complete.dropna()

	print(soybean_meal_complete)
	print(crude_oil_complete)

	#แยก เดือน ปี
	soybean_meal_complete['New_Month'] = pd.to_datetime(soybean_meal_complete['Date']).dt.strftime('%m').astype('int')
	soybean_meal_complete['Year'] = pd.to_datetime(soybean_meal_complete['Date']).dt.strftime('%Y').astype('int')
	crude_oil_complete['New_Month'] = pd.to_datetime(crude_oil_complete['Date']).dt.strftime('%m').astype('int')
	crude_oil_complete['Year'] = pd.to_datetime(crude_oil_complete['Date']).dt.strftime('%Y').astype('int')
	soybean_meal_complete = soybean_meal_complete[['New_Month', 'Year','Soybean_meal_us']]
	crude_oil_complete = crude_oil_complete[['New_Month', 'Year', 'Crude_Oil']]

	print('newwwwwwwwwwwwwwwwwwwww')
	# print(crude_oil_complete)
	print(soybean_meal_complete)

	#--------- ทำ array check status เดือนที่ขาดของ crude oil and soybean ----------
	import numpy as np

	#array status
	check = []
	reverse = 12
	print('startttttttttttttttttttttt')
	print(month)

	for i in range(4):
		if (month <= 0):
			check.append((reverse,0))
			reverse = reverse - 1
		else:
			check.append((month,0))
		month = month - 1
		crude_oil_mat_vals = np.vstack(check)
		soybean_mat_vals = np.vstack(check)

	print('check stata')
	print(check)
	#new array
	crude_oil_mat_vals = np.delete(crude_oil_mat_vals, 0, 0)
	soybean_mat_vals = np.delete(soybean_mat_vals, 0, 0)

	#--------- check shape dataframe ของ Crud oil and Soybean meal ถ้าไม่ครบก็จะไปใส่สถานะ ใน array soybean_mat_vals / crude_oil_mat_vals
	#ของ SOYBEAN MEAL
	if soybean_meal_complete.shape == (3, 2):
		print('yes')
	else:
		# ใส่สถานะว่าเดือนไหนมีข้อมูล
		array_soybean_for_status = np.array(soybean_meal_complete)
		for i in range(len(soybean_mat_vals)):
			for j in range(len(array_soybean_for_status)):
				if soybean_mat_vals[i][0] == int(array_soybean_for_status[j][0]):
					print(soybean_mat_vals[i][0])
					soybean_mat_vals[i][1] = 1
	print('----------soybean_mat_vals-----------')
	print(soybean_mat_vals)

	#ของ CRUDE OIL
	if crude_oil_complete.shape == (3, 2):
		print('yes')
	else:
		# ใส่สถานะว่าเดือนไหนมีข้อมูล
		array_crude_oil_for_status = np.array(crude_oil_complete)
		for i in range(len(crude_oil_mat_vals)):
			for j in range(len(array_crude_oil_for_status)):
				if crude_oil_mat_vals[i][0] == int(array_crude_oil_for_status[j][0]):
					print(crude_oil_mat_vals[i][0])
					crude_oil_mat_vals[i][1] = 1


	print('----------crude_oil_mat_vals-----------')
	print(crude_oil_mat_vals)

	#ปริ้นอาเรย์เช็คสถานะออกมาดู count เอาไว้นับจำนวนเดือนที่ขาดเพื่อใช้ใน loop ถัดไป
	count_null_soybean = 0
	for i in range(len(soybean_mat_vals)):
		for j in range(2):
			if soybean_mat_vals[i][j]==0:
				count_null_soybean+=1
	print('count_null_soybean')
	print(count_null_soybean)
	#
	count_null_crude_oil = 0
	for i in range(len(crude_oil_mat_vals)):
		for j in range(2):
			if crude_oil_mat_vals[i][j] == 0:
				count_null_crude_oil += 1
	print('count_null_crude_oil')
	print(count_null_crude_oil)


	#ใส่ null to crude oil dataframe and soybean meal สำหรับเดือนที่ขาด
	#soybean
	for i in range(len(soybean_mat_vals)):
		if soybean_mat_vals[i][1] == 0:
			if soybean_mat_vals[i][0] == 12:

				fill_Null = {'New_Month': soybean_mat_vals[i][0], 'Year': year - 544, 'Soybean_meal_us': [np.nan]}
				fill_Null_Data = pd.DataFrame(fill_Null)  #แปลงเป้น dataframe

				frames1 = [soybean_meal_complete, fill_Null_Data]

				soybean_meal_complete = pd.concat(frames1)

				soybean_meal_complete = soybean_meal_complete.sort_values(by=['New_Month'])
				soybean_meal_complete = soybean_meal_complete.fillna(soybean_meal_complete.mean())

			else:
				fill_Null_soy = {'New_Month': soybean_mat_vals[i][0], 'Year': year - 543,'Soybean_meal_us': [np.nan]}
				fill_Null_Data_soy = pd.DataFrame(fill_Null_soy)  # แปลงเป้น dataframe

				frames_soy = [soybean_meal_complete, fill_Null_Data_soy]

				soybean_meal_complete = pd.concat(frames_soy)

				soybean_meal_complete = soybean_meal_complete.sort_values(by=['New_Month'])
				soybean_meal_complete = soybean_meal_complete.fillna(soybean_meal_complete.mean())

	#crude oil
	for i in range(len(crude_oil_mat_vals)):
		if crude_oil_mat_vals[i][1] == 0:
			if crude_oil_mat_vals[i][0] == 12:

				fill_Null_soy = {'New_Month': crude_oil_mat_vals[i][0], 'Year': year - 544, 'Crude_Oil': [np.nan]}
				fill_Null_Data_soy = pd.DataFrame(fill_Null_soy)  #แปลงเป้น dataframe
				# รวม dataframe ข้อมูลที่มีกับข้อมูลที่ null เข้าด้วยกันแล้ว sort และเติมค่า mean
				# print('result_for_predict----')
				# print(result_for_predict)
				# print('------------')
				frames_oil = [crude_oil_complete, fill_Null_Data_soy]

				crude_oil_complete = pd.concat(frames_oil)

				crude_oil_complete = crude_oil_complete.sort_values(by=['New_Month'])
				crude_oil_complete = crude_oil_complete.fillna(crude_oil_complete.mean())

			else:
				fill_Null_oil = {'New_Month': crude_oil_mat_vals[i][0], 'Year': year - 543,'Crude_Oil': [np.nan]}
				fill_Null_Data_oil = pd.DataFrame(fill_Null_oil)  # แปลงเป้น dataframe

				frames_oil = [crude_oil_complete, fill_Null_Data_oil]

				crude_oil_complete = pd.concat(frames_oil)

				crude_oil_complete = crude_oil_complete.sort_values(by=['New_Month'])
				crude_oil_complete = crude_oil_complete.fillna(crude_oil_complete.mean())

		print('fill_Null_Data_oil')
		print('crude_oil_complete')
		print(crude_oil_complete)
		# print(fill_Null_Data_oil)



	#เอา dataframe 2 อันมารวมกัน crude_oil_complete+soybean_meal_complete
	new_soybean_for_concat = pd.DataFrame(soybean_meal_complete, columns=['Soybean_meal_us'])
	new_soybean_for_concat = new_soybean_for_concat.reset_index(drop=True)
	crude_oil_complete = crude_oil_complete.reset_index(drop=True)
	data_from_excel_complete  = pd.concat([crude_oil_complete, new_soybean_for_concat], axis=1)

	print('เอา dataframe 2 อันมารวมกัน crude_oil_complete+soybean_meal_complete')
	print(data_from_excel_complete)
	#----------------------------------จัดการ data excel เสร็จแล้ว -------------------------------------------.

	# ข้อมูล Input user from User Interface
	user_input = [[d['New_Month'], year - 543, d['Crude_Oil'], d['Soybean_meal_US']]]
	print('#ข้อมูล Input user from User Interface')
	print(user_input)
	# เอา dataframe data_from_excel_complete ข้อมูลจากผู้ใช้ที่หน้า UI
	user_input_for_concat = pd.DataFrame(user_input, columns=['New_Month', 'Year', 'Crude_Oil', 'Soybean_meal_us'])
	user_input_for_concat = user_input_for_concat.reset_index(drop=True)
	data_from_excel_complete = data_from_excel_complete.reset_index(drop=True)
	frames_last = [data_from_excel_complete, user_input_for_concat]
	complete_all_data = pd.concat(frames_last)
	print('complete_all_data')
	print(complete_all_data)

	# ----------------------------------จัดการ data ทุกอย่างเรียบร้อย -------------------------------------------.

	# dataframe reslut for predict1 to array for predict
	list_for_predict = complete_all_data.values.tolist()
	list_for_predict
	array_for_predict = np.array(list_for_predict)
	print(array_for_predict.shape)  # shape (4,4)
	array_for_predict = array_for_predict.reshape((1, 4, 4))  # reshape (1,4,4) จะได้ทำนายได้

	#เอาอาเรย์ไปทำนาย
	model = tf.keras.models.load_model('Bidirectional_4_slide_mape4point5.h5', compile=False)


	model.compile(loss='mean_squared_error',
				  optimizer='adam', metrics=[tf.keras.metrics.MeanAbsolutePercentageError(),
											 tf.keras.metrics.MeanAbsoluteError(),
											 tf.keras.metrics.MeanSquaredError()])

	result_predict = model.predict(array_for_predict)
	# # print("ราคาที่ทำนายได้ของวันที่ " + end_date + " เท่ากับ " + str(result_predic[0][0]))
	num = float(result_predict[-1])
	print(type(num))
	predict = "{:.2f}".format(round(num, 2))
	print(predict)

	return jsonify(predict)

if __name__ == '__main__':
	app.run()