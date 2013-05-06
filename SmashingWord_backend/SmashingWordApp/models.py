from django.db import models
import django

# Create your models here.
SUCCESS               =   1  # : a success
ERR_BAD_CREDENTIALS   =  -1  # : (for login only) cannot find the user/password pair in the database
ERR_USER_EXISTS       =  -2  # : (for add only) trying to add a user that already exists
ERR_BAD_USERNAME      =  -3  # : (for add, or login) invalid user name (only empty string is invalid for now)
ERR_BAD_PASSWORD      =  -4
FAILURE = -5

class User(models.Model):
	userName = models.TextField(max_length=128, primary_key=True, blank=False)
	#Shouldn't save password in our db, leave it like that for now. will fix later. 
	password = models.TextField(max_length=128)
	email = models.TextField(max_length=128, blank=False)
	count = models.IntegerField()
	balance=models.IntegerField()
	level = models.IntegerField()
	mpMoney = models.IntegerField()
	mpScore = models.IntegerField()
	spScore = models.IntegerField()


	
	def __unicode__(self):
		return str((self.userName, self.password, self.count, self.email, self.score))
	def TESTAPI_resetFixture(self):
		User.objects.all().delete()
		return SUCCESS
	def add(self,inUserName,inPwd, inEmail, inCount=1,Balance=0, Level=0, MpMoney=0, MpScore=0, SpScore=0):
		code=1
		if self.userExist(inUserName)[0]:
			code=ERR_USER_EXISTS
		if not self.validateUsername(inUserName):
			code = ERR_BAD_USERNAME
        	if not self.validatePassword(inPwd):
			code= ERR_BAD_PASSWORD
		tobeAdd = User(userName=inUserName, password = inPwd,count=inCount, email = inEmail,balance=Balance, level=Level, mpMoney = MpMoney, mpScore=MpScore, spScore = SpScore)
		tobeAdd.save()
		return (code,{})

	def login(self, inUserName, inPwd):
		code= 1
		temp = self.userExist(inUserName)
		if temp[0] and temp[1].password == inPwd:
			print(inPwd)
			print(temp[1].password)
			#Auth succeed
			temp[1].count+=1
			tempCount = temp[1].count
			temp[1].save()
			code = SUCCESS
			data=self.parseHandler(temp[1])
		else:
			code=ERR_BAD_CREDENTIALS
			data = {}
		return (code, data)
			
	def getTopScores(self):
		try:
			dbResult = User.objects.order_by("-mpScore")[0:10]
			print(type(dbResult))
			return (SUCCESS, self.parseHandler(dbResult,'easy'))
		except Exception as e:
			print (e)
			return (FAILURE, {})

	def saveScore(self, inUser, inScore):
		try:
			dbResult = User.objects.get(userName = inUser)
			dbResult.mpScore = inScore
			dbResult.save()
			code = SUCCESS
		except:
			code=FAILURE
		return (code, {})
			


	def userExist(self,inUserName):
		try:
			dbresult = User.objects.get(userName = inUserName)
			Exist = True
		except:
			Exist=False
			dbresult = ""
		return (Exist,dbresult)

	def validateUsername(self, name):
		return name!="" and len(name)<=	128
	def validatePassword(self, pwd):
		return len(pwd)<=128

	def parseHandler(self,userObj, mode = 'fullInfo'):
		if userObj==[] or userObj==None:
			return {}
		if type(userObj)==django.db.models.query.QuerySet:
			data=[]
			for elem in userObj:
				if mode=='fullInfo':
					data.append(self.parser(elem))
				else:
					data.append(self.easyParser(elem))
			return data
		else:
			if mode == 'fullInfo':
				return self.parser(userObj)
			else:
				return self.easyParser(userObj)
	def parser(self, user):
		return {'user':user.userName, 'password':user.password, 'email':user.email, 'count':user.count, 'balance':user.balance, 'level':user.level, 'mpMoney':user.mpMoney, 'mpScore':user.mpScore, 'spScore':user.spScore}
	def easyParser(self, user):
		return {'user':user.userName, 'score':user.mpScore}


			


class Word(models.Model):
	word = models.TextField(max_length=128, primary_key=True, blank=False)
	level= models.IntegerField()
	def add(self,Inword,Inlevel=1):
        	if len(Inword)==0:
			return -1
		tobeAdd = Word(word=Inword, level = Inlevel)
		tobeAdd.save()
		return 1
class Item(models.Model):
	name = models.TextField(max_length=128, blank=False)
	price = models.IntegerField(blank=False)
	ItemId = models.IntegerField(primary_key=True,blank=False)

class OwnItem(models.Model):
	userName = models.ForeignKey(User)
	itemId = models.ForeignKey(Item)





