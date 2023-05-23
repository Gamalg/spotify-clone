#  Authorization process

## Scheme
 
 App Launch -> Is signed in?
 - Yes: -> Show main page
 - No: -> Show Sign in view -> Sign in -> Open webview -> grant access -> token request -> Get Token -> close web view and sign in -> Show Main

## After sign in

1. Save token 
2. Refresh if needed:
- In app 
- After long inactivity
