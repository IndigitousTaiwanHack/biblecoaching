# biblecoaching

We provide bible platform to share your life experience, bible thinking and how to use in bible for everyone.
Everyone can be your bible coach when point the view from bible. Let yourself grow up in bible.

#Install
* Run $ pod install
* Open the MyApp.xcworkspace that was created. This should be the file you use everyday to create your app.


We will use Face api by Mircosoft developer. You can reference this website to register and to get api key.

Mircosoft Face api 
https://www.microsoft.com/cognitive-services/en-us/face-api


#info.plist

Find "info.plist" file in the root. You must fill in two parameters , one is SERVER_IP and the other is EmotionDetectKey.

* SERVER_IP : Add the ip address which you build the server.
* EmotionDetectKey : Emotional api key by face api after you register in "https://www.microsoft.com/cognitive-services/en-us/face-api".
