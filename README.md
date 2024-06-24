# adsl-dev

This repository for publishing latest Web rendering engine to develop ADSL
THis rendering engine is fast website developing and mobile app proto-typing and delivering.

## Setup

1. Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. Once you have Git installed, go ahead and git clone this [adsl-dev repo](https://github.com/yubose/adsl-dev)
3. Start up a local testing server with [index.html](hyuge_com/index.html) as your root file by using a local server tool of your choice.

   With [VSCode](https://code.visualstudio.com/):
    - Search and install VSCode extension - [Live Server by Ritwick]
        (https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
        This extension will be used to start up the local testing server.
    - "Live Server" settings: click on the setting icon, it shows clear instruction to change setting. default setting is working well.
   - Once you have these installed,
      - "open fold"  at .../hyuge_com
      - right click on the [index.html](hyuge_com/index.html) and click on "Open with Live Server." The local server should open on port 5500.
       Your browser should automatically open http://127.0.0.1:5500/hyuge_com/index.html, but if not go to the url and you should see the website homepage.

     - There are various advantages on using a local server as opposed to opening the index.html file in your browser as explained here <https://developer.mozilla.org/en-US/docs/Learn/Common_questions/Tools_and_setup/set_up_a_local_testing_server>. Some other local server tools can be found here as well if you wish to use something else.

  the ADSL (yaml) config file is local.yml is in the same directory as index.html. The ADSL rendering engine uses it to load the ADSL file set for the website of web app.
  
In this repo, there are 4 adsl file sets:
	hyuge_com/adsl_app
		This is a completed website in ADSL
    hyuge_com/HelloWorld
		This is the minimal text(Hello World) web site to display simply text.
    testpage/testpage
		This shows various view components which can be rendered with current renderring engine.
	testpage/testpage2
		This is typical web-app with signin/signup with cloud resource connection to BECOS
