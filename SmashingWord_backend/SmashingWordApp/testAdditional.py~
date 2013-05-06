"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

        
class TestAmbition(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = None, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)
    #Long username. >128
    def testAdd2(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '1'*200, 'password' : 'password','email':'email'} )
	self.assertDictEqual(respData,{ 'Code': testLib.RestTestCase.ERR_BAD_USERNAME,'data':{}})
    #Emtpy username
    def testAdd3(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password','email':'email'} )
        self.assertDictEqual(respData, { 'Code': testLib.RestTestCase.ERR_BAD_USERNAME,'data':{}})
    #Regular Add user, success. And test whether score, level etc are default to be 0
    def testAdd4(self):
	respData = self.makeRequest("/users/add", method="POST", data={'user':'wenhaocen','password':'password','email':'boss@hotmail.com'})
	respData = self.makeRequest("/users/login", method="POST", data={'user':'wenhaocen','password':'password'})
	self.assertDictEqual({'Code':1, 'data':{'user':'wenhaocen', 'password':'password','email':'boss@hotmail.com','count':2,'balance':0, 'level':0, 'mpMoney':0, 'spScore': 0,'mpScore':0}}, respData)
	
    #Try to add user that already exists
    def testAdd5(self):
	respData = self.makeRequest("/users/add", method="POST", data={'user':'wenhaocen', 'password': 'wenhaocen','email':'email'})
	self.assertDictEqual({'Code':1, 'data':{}}, respData)
	respData = self.makeRequest("/users/add", method="POST", data={'user':'wenhaocen', 'password': 'wenhaocen','email':'email'})
	self.assertDictEqual({'Code':testLib.RestTestCase.ERR_USER_EXISTS,'data':{}},respData)
    #Add user with empty password, should return success
    def testAdd6(self):
	respData = self.makeRequest("/users/add", method="POST", data={'user':'wenhaocen', 'password': '','email':'email'}) 
	self.assertDictEqual({'Code':testLib.RestTestCase.SUCCESS, 'data':{}}, respData) 
    #Try to login with user doesn't exist
    def testLogin(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'wenhaocen', 'password' : 'wenhaocen'} )
        self.assertDictEqual({'Code':testLib.RestTestCase.ERR_BAD_CREDENTIALS, 'data':{}}, respData) 
    #Log in with bad credentials
    def testLogin2(self):
	respData = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'password'*300})
	self.assertDictEqual({'Code':testLib.RestTestCase.ERR_BAD_CREDENTIALS, 'data':{}}, respData)
    #Add an user with an empty password, and then login with the credentials. should return success
    def testLogin4(self):
	respData = self.makeRequest("/users/add", method="POST", data={'user':'wenhaocen', 'password': '','email':'email'})
	respData = self.makeRequest("/users/login", method="POST", data={'user':'wenhaocen','password':''})
	self.assertDictEqual({'Code':1, 'data':{'user':'wenhaocen', 'password':'','email':'email','count':2,'balance':0, 'level':0, 'mpMoney':0, 'spScore': 0,'mpScore':0}}, respData)
    #Do a add user with empty password, and then login with some password, should return bad credentials
    def testTop10(self):
	self.makeRequest("/users/add", method="POST", data={'user':'1', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'2', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'3', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'4', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'5', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'6', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'7', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'8', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'9', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'10', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'11', 'password': '','email':'email'})
	self.makeRequest("/users/add", method="POST", data={'user':'12', 'password': '','email':'email'})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'1', 'score':1})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'2', 'score':2})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'3', 'score':3})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'4', 'score':4})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'5', 'score':5})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'6', 'score':6})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'7', 'score':7})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'8', 'score':8})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'9', 'score':9})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'10', 'score':10})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'11', 'score':11})
	self.makeRequest("/users/saveScore", method="POST", data={'user':'12', 'score':12})
	respData = self.makeRequest("/users/Top10Scores", method="GET",data={})
	#print (respData)
	#print ({'Code':testLib.RestTestCase.SUCCESS,'data':[{'user':12, 'score':12},{'user':11, 'score':11},{'user':10, 'score':10},{'user':9, 'score':9},{'user':8, 'score':8},{'user':7, 'score':7},{'user':6, 'score':6},{'user':5, 'score':5},{'user':4, 'score':4},{'user':3, 'score':3}]})
	self.assertDictEqual({'Code':testLib.RestTestCase.SUCCESS,'data':[{'user':'12', 'score':12},{'user':'11', 'score':11},{'user':'10', 'score':10},{'user':'9', 'score':9},{'user':'8', 'score':8},{'user':'7', 'score':7},{'user':'6', 'score':6},{'user':'5', 'score':5},{'user':'4', 'score':4},{'user':'3', 'score':3}]},respData)



	
    



    
