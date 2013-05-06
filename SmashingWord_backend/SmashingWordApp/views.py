# Create your views here.
from django.http import HttpResponse
from django.template import Context, loader
from SmashingWordApp.models import User
from SmashingWordApp.models import Word
# import the logging library
from django.views.decorators.csrf import csrf_protect
import logging
from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.views.decorators.csrf import csrf_exempt
import sys 
from os import curdir, sep
import os
from django.http import Http404
import json
import models
import cgi
import tempfile
import traceback
import StringIO
import unittest
from testAdditional import TestAmbition
# Import smtplib for the actual sending function
import smtplib
# Import the email modules we'll need
from email.mime.text import MIMEText
g_user = models.User()
g_word = models.Word()


SUCCESS               =   1  # : a success
ERR_BAD_CREDENTIALS   =  -1  # : (for login only) cannot find the user/password pair in the database
ERR_USER_EXISTS       =  -2  # : (for add only) trying to add a user that already exists
ERR_BAD_USERNAME      =  -3  # : (for add, or login) invalid user name (only empty string is invalid for now)
ERR_BAD_PASSWORD      =  -4
FAILURE=-5

# Get an instance of a logger
log = logging.getLogger(__name__)
@csrf_exempt
def index(request): 
	if request.method == "POST":
		if request.path.find("/users/")==0:
			return UserController(request)
		elif request.path.find("/TESTAPI/")==0:
			return TESTController(request)
		else:
			raise Http404
	elif request.method=="GET":
		content_type="application/json"
		if request.path == "/users/Top10Scores":
			result = g_user.getTopScores()
			return HttpResponse(json.dumps({'Code': result[0],'data':result[1]}),content_type="application/json" )
		elif request.path =="/requestPassword":
			errCode=requestPassword(request)
			return HttpResponse(json.dumps({'errCode': errCode}),content_type="application/json" )
		else:
			return render_to_response('SmashingWordApp'+request.path,mimetype="text/html")
#still working on this function.
def requestPassword(request):
	inData = json.loads(request.body)
	inEmail = inData['email']
	try:
		userDetails = g_user.objects.get(email=inEmail)
		email = userDetails.email
		password = userDetails.password
		msg = MIMEText("Dear Smashing Word User, your password is " + password+" . Enjoy")

		# me == the sender's email address
		# you == the recipient's email address
		msg['Subject'] = 'Password Recovery'
		msg['From'] = 'boss@smashingWord.com'
		msg['To'] = email

		# Send the message via our own SMTP server, but don't include the
		# envelope header.
		s = smtplib.SMTP('localhost')
		s.sendmail('boss@smashingWord.com', [email], msg.as_string())
		s.quit()
		return SUCCESS
	except:
		return FAILURE

	
@csrf_exempt
def TESTController(request):
	if request.path=="/TESTAPI/resetFixture":
		g_user.TESTAPI_resetFixture()
		return HttpResponse(json.dumps({'errCode': SUCCESS}),content_type="application/json" )
	elif request.path== "/TESTAPI/unitTests":
		buf = StringIO.StringIO()
		suite = unittest.TESTLoader().loadTestsFromTestCase(TestAmibition)
		result = unittest.TextTestRunner(stream = buf, verbosity=2).run(suite)
		return HttpResponse(json.dumps({'totalTests': result.testsRun ,  'nrFailed': len(result.failures), 'output':buf.getvalue()}),content_type="application/json" )
            
        else:
            raise Http404
	
@csrf_exempt
def UserController(request):
	inData = json.loads(request.body)
	#sys.stderr.write(str(inData))
	#inData = dict(request.POST)
	#sys.stderr.write(str(inData.keys()))
	#sys.stderr.write(str(type(inData)))
	if 'user' in inData:
		inUserName = inData["user"]
	if 'password' in inData:
		inpassword = inData["password"]
	if 'email' in inData:
		inEmail = inData['email']
	if 'score' in inData:
		inScore = inData['score']
	if request.path == "/users/login":
			#result is a tuple of two, where first item is the code, second item is the data. Data can be either array or dictionary. When it's an array, that means it contains an array of user info. when it's a dictionary, that means it only contains info of one user.	
			result = g_user.login(inUserName, inpassword)
	elif request.path=="/users/add":
			result = g_user.add(inUserName, inpassword, inEmail )
	elif request.path=="/users/saveScore":
			result = g_user.saveScore(inUserName, inScore)
	else:
		raise Http404
	return HttpResponse(json.dumps({'Code': result[0], 'data':result[1]}),content_type="application/json" )

		
