/*
 Copyright © 2014 myOS Group.
 
 This application is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 Lesser General Public License for more details.
 
 Contributor(s):
 Amr Aboelela <amraboelela@gmail.com>
 */

#import <MLKit/MLKit.h>

#pragma mark - Static functions

static void _UIApplicationProcessInitialize()
{
    int argc=1;
    char** argv;
    char** env;
    
    const char *myArgv[] = {"AppName",0};
    argv = myArgv;
    const char *myEnv[] = {
        "TERM_PROGRAM=Apple_Terminal",
        "SHELL=/bin/bash",
        "TERM=xterm-256color",
        "TMPDIR=/var/folders/xl/dry9v7p17w38w8v4sy1wsyr40000gn/T/",
        "Apple_PubSub_Socket_Render=/tmp/launch-lVth2w/Render",
        "TERM_PROGRAM_VERSION=309",
        "TERM_SESSION_ID=02C012FB-0CBF-4target=android-192-BD1D-B03C6CAAE8A1",
        "USER=amr",
        "COMMAND_MODE=unix2003",
        "SSH_AUTH_SOCK=/tmp/launch-17Hdqv/Listeners",
        "Apple_Ubiquity_Message=/tmp/launch-knmMB6/Apple_Ubiquity_Message",
        "__CF_USER_TEXT_ENCODING=0x1F5:0:0",
        "PATH=/Users/amr/develop/adt/ndk:/Users/amr/develop/adt/sdk/tools:/Users/amr/develop/adt/sdk/platform-tools:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin",
        "PWD=/Users/amr/Documents/kit/ndk",
        "EDITOR=vim",
        "LANG=en_US.UTF-8",
        "HOME=/Users/amr",
        "SHLVL=2",
        "KIT_PATH=/Users/amr/Documents/kit",
        "LOGNAME=amr",
        "DISPLAY=/tmp/launch-8M6diV/org.macosforge.xquartz:0",
        "MACHINE_USERNAME=amr",
        "_=./HelloWorld",
        0
    };
    env = myEnv;
    GSInitializeProcess(argc, argv, env);
}

int main(void)
{
    _UIApplicationProcessInitialize();
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *appName = @"Console";
    [[NSProcessInfo processInfo] setProcessName:appName];
    
    //NSString *aString = ;
    //DLog(@"aMessage: %@", aMessage);
    int pipeRead = [MLShellManagerReadStringFromPipe(0) intValue];
    DLog(@"pipeRead: %d", pipeRead);
    //dup2(0, pipeRead);
    close(0);
    
    MLPipeMessage message = -1;
    while (message != MLPipeMessageTerminateApp) {
        message = MLShellManagerReadMessageFromPipe(pipeRead);
        switch (message) {
            case MLPipeMessageEndOfMessage:
                break;
            case MLPipeMessageWillEnterBackground:
                DLog(@"MLPipeMessageWillEnterBackground");
                break;
            case MLPipeMessageHello:
                DLog(@"MLPipeMessageHello");
                break;
            case MLPipeMessageTerminateApp:
                DLog(@"MLPipeMessageTerminateApp");
                break;
            default:
                break;
        }
    }
    //close(mypipe[0]);
    //exit(EXIT_SUCCESS);
    [pool release];
}
