// JavaScript Document
$(document).ready(function () {
	$('#netwayfeed').rssfeed(' http://blog.netway.co.th/category/news/feed/', {
		limit: 4, <!--- จำกัดจำนวนไม่เกิน ที่กำหนด -->
		offset: 1, <!--- เริ่มหัวข้อข่าวที่เท่าไหร่ -->
		ssl: true,
		date: false ,
		content: 0,   <!--- เนื้อหาข่าว -->
		header: false  <!--- หัวข้อข่าว -->
	});//1update & news

	$('#cloud-hostingfeed').rssfeed('http://blog.netway.co.th/category/cloud-vps/feed/', {
		limit: 4,
		offset: 1,
		ssl: true,
		date: false ,
		content: 0,
		header: false
	});//2tutorial

	$('#google-appsfeed').rssfeed('http://blog.netway.co.th/category/email-service/feed/', {
		limit: 4,
		offset: 1,
		ssl: true,
		date: false ,
		content: 0,
		header: false
	});//3twitter


	$('#web-hostingfeed').rssfeed('http://blog.netway.co.th/category/shared-hosting/feed/', {
		limit: 4,
		offset: 1,
		ssl: true,
		date: false ,
		content: 0,
		header: false
	});//4product update

	$('#ssl-and-securityfeed').rssfeed('http://blog.netway.co.th/category/ssl/feed/', {
		limit: 4,
		offset: 1,
		ssl: true,
		date: false ,
		content: 0,
		header: false
	});//5product 
	
	$('#googleapps-office').rssfeed('http://blog.netway.co.th/category/about/googleapps-microsoftoffice365/feed/', {
		limit: 10,
		offset: 1,
		ssl: true,
		date: false ,
		content: 0,
		header: false
	});//googleapps and office365 

});



