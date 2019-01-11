//
//  main.m
//  Undecimus
//
//  Created by pwn20wnd on 8/29/18.
//  Copyright © 2018 - 2019 Pwn20wnd. All rights reserved.
//

#include <dlfcn.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include "SettingsTableViewController.h"
#import "utils.h"

int outputpipe[2];
int orig_stderr;
int orig_stdout;
int logfd=-1;
bool outputpipesPresent=false;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        orig_stdout = dup(STDOUT_FILENO);
        orig_stderr = dup(STDERR_FILENO);
        outputpipesPresent = !pipe(outputpipe);
        open_logs();
        if (outputpipesPresent) {
            dup2(outputpipe[1], STDOUT_FILENO);
            dup2(outputpipe[1], STDERR_FILENO);
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

