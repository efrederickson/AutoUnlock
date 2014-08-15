#import <substrate.h>
#import <LibPass/LibPass.h>

@class SBLockScreenNotificationListController;

@interface SBLockScreenViewController
-(SBLockScreenNotificationListController*)_notificationController;
@end

@interface SBUserAgent
+(id)sharedUserAgent;
-(BOOL)lockScreenIsShowing;
-(BOOL)deviceIsPasscodeLocked;
-(BOOL)deviceIsLocked;
-(id)init;
@end

@interface SBMediaController
+(id)sharedInstance;
-(BOOL)isPlaying;
@end

%hook SBLockScreenViewController
-(void) _handleDisplayTurnedOn
{
    %orig;
    
    //if ([[%c(SBUserAgent) sharedUserAgent] deviceIsPasscodeLocked])
    //    return;

    if ([[%c(SBMediaController) sharedInstance] isPlaying])
        return;

    id notifView = [self _notificationController];
    if (notifView)
    {
        NSMutableArray *li = MSHookIvar<NSMutableArray *>(notifView, "_listItems");
        if (li && [li count] > 0)
                return;
    }

    [[%c(LibPass) sharedInstance] unlockWithCodeEnabled:NO];
}
%end
