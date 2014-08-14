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
    
    for (NSDictionary *event in events)
    {
        NSString *homeworkTitle = [event objectForKey: @"title"];
        
        NSString *homeworkSubject = [event objectForKey: @"subject"];
        
        NSString *homeworkDescription = [event objectForKey: @"description"];
        
        NSString *homeworkDueDate = [event objectForKey: @"due_date"];
        
        NSString *calendarTitle = [NSString stringWithFormat: @"%@ - %@",homeworkSubject,homeworkTitle];
        
        NSDate *calendarDate = [dateFormatter dateFromString:homeworkDueDate];
        
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
        {
            
            if (!granted) { return; }
            EKEvent *calendarEvent = [EKEvent eventWithEventStore:store];
            calendarEvent.title = calendarTitle;
            calendarEvent.notes = homeworkDescription;
            calendarEvent.startDate = [calendarDate dateByAddingTimeInterval:-60*60*24];
            calendarEvent.allDay = YES;
            calendarEvent.endDate = calendarDate;
            [calendarEvent setCalendar:[store defaultCalendarForNewEvents]];
            NSError *err = nil;
            [store saveEvent:calendarEvent span:EKSpanThisEvent commit:YES error:&err];
            //NSString *savedEventId = calendarEvent.eventIdentifier;
        
        }];
        
    }

    
}

@end
