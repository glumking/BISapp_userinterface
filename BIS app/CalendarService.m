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
    
    NSMutableArray  *unstoredEvents = [events mutableCopy];
    
    NSArray *storedEvents = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeworkEvents"];
    
    [unstoredEvents removeObjectsInArray:storedEvents];
    
    [CalendarService storeEvents:unstoredEvents];
    
    return unstoredEvents;
    
}
@end
