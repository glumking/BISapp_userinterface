//
//  CalendarService.m
//  BIS app
//
//  Created by phillips on 8/14/14.
//  Copyright (c) 2014 ICEHOUSE-internship. All rights reserved.
//

#import "CalendarService.h"
#import <EventKit/EventKit.h>

@implementation CalendarService

+ (void)addEventsToCalendar:(NSArray *)events
{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy'-'MM'-'dd"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+7"]];
    
    NSArray *unstoredEvents = [CalendarService removeStoredEvents:events];
    
    for (NSDictionary *event in unstoredEvents)
    {
        NSString *homeworkTitle = [event objectForKey: @"title"];
        
        NSString *homeworkSubject = [event objectForKey: @"subject_id"];
        
        NSString *homeworkDescription = [event objectForKey: @"description"];
        
        NSString *homeworkDueDate = [event objectForKey: @"due_date"];
        
        NSString *calendarTitle = [NSString stringWithFormat: @"%@ - %@",homeworkSubject,homeworkTitle];
        
        NSDate *calendarDate = [dateFormatter dateFromString:homeworkDueDate];
        
        NSTimeInterval startInterval = -60*60*6;
        NSTimeInterval endInterval = 60*60*7;
        
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
        {
            if (!granted) { return; }
            EKEvent *calendarEvent = [EKEvent eventWithEventStore:store];
            calendarEvent.title = calendarTitle;
            calendarEvent.notes = homeworkDescription;
            calendarEvent.startDate = [calendarDate dateByAddingTimeInterval:startInterval];
            calendarEvent.endDate = [calendarDate dateByAddingTimeInterval:endInterval];
            
            [calendarEvent addAlarm:[EKAlarm alarmWithRelativeOffset:startInterval]];
            [calendarEvent setCalendar:[store defaultCalendarForNewEvents]];
            
            NSError *err = nil;
            [store saveEvent:calendarEvent span:EKSpanThisEvent commit:YES error:&err];
        }];
        
    }
    
}

+ (void)storeEvents:(NSArray *)events
{
    
    [[NSUserDefaults standardUserDefaults] setObject:events forKey:@"homeworkEvents"];
    
}

+ (NSArray*)removeStoredEvents:(NSArray *)events
{
    
    NSMutableArray *unstoredEvents = [events mutableCopy];
    
    NSMutableArray *guiltyEvents = [[NSMutableArray alloc] init];
    
    NSArray *storedEvents = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeworkEvents"];
    
    for (NSDictionary *suspectDictionary in unstoredEvents) {
        
        BOOL guilty = NO;
        
        for (NSDictionary *storedDictionary in storedEvents) {
            
            NSString *suspectSubject = [suspectDictionary objectForKey: @"subject_id"];
            
            NSString *suspectTitle = [suspectDictionary objectForKey: @"title"];
            
            NSString *suspectDescription = [suspectDictionary objectForKey: @"description"];
            
            NSString *suspectDueDate = [suspectDictionary objectForKey: @"due_date"];
            
            NSString *storedSubject = [storedDictionary objectForKey: @"subject_id"];
            
            NSString *storedTitle = [storedDictionary objectForKey: @"title"];
            
            NSString *storedDescription = [storedDictionary objectForKey: @"description"];
            
            NSString *storedDueDate = [storedDictionary objectForKey: @"due_date"];
            
            if( [suspectSubject isEqual: storedSubject] && [suspectTitle isEqual: storedTitle] && [suspectDescription isEqual: storedDescription] && [suspectDueDate isEqual: storedDueDate]){
                
                guilty = YES;
                
            }
        }
        
        if (guilty){
            
            [guiltyEvents addObject:suspectDictionary];
            
        }
        
    }
    
 [unstoredEvents removeObjectsInArray:guiltyEvents];
    
    [CalendarService storeEvents:unstoredEvents];
    
    return unstoredEvents;
    
}
@end
