# SpeedRoommating

SpeedRoommating is a SpareRoom service where people meet potential roommates while socialising in a public venue. Its app is used by SpareRoom employees to help speed up checking in attendees.

Eventually the app will look like this: https://app.zeplin.io/project/602ce0601122751809bc2d9c/dashboard


## My decisions

1. Create a separate repository with a separate codebase for fetching the events from the server. 
	This was a decision taken partly to demonstrate knowledge of SPM and separation of concerns. It was also an opportunity to make something headless, which is inherently easier to have more complete testing on.  
2. Start with a janky vertical slice and build out.  
	I chose to do this firstly to demonstrate that I could refactor my way out of something pretty bad and add testing to that. It was also a quick way of getting a vertical slice so I could evisage the rest of the app more easily and build around it.
3. Not worry too much about font styles and sizes.
	Initially I was copying all the font sizes and styles directly from Zeplin, but all the measurements are just _off_ in a real app. They don't look right. So what I have right now is a mix of measurements taken directly from that and what I think looks better. I was going through matching them perfectly to what was in Zeplin to demonstrate attention to detail, but it would've looked terrible.
4. As of the time that I am writing this I have left in some bad abstractions. 
	It is my intent to refactor most of these out before submission, but my focus was on getting something with a fairly complete feature set and _good enough_ abstraction. I have mostly left notes where this badness occurs.
5. Test the complicated stuff. 
	The coverage in this repository is not as good as I would like or I was aiming for initially. Ultimately, I have opted for a more complete product over super-rigerous testing, but I have tested the bits that, for me, it made sense to test. A more complete approach to testing is demonstrated in the Repo project, but more unit and UI testing is very desirable.
6. Neglect a race condition in Kingfisher.
	I have chosen to use Kingfisher to cache images, particularly as there's a lot of duplication. The only issue is that I'm seeing a race condition internally within Kingfisher and sometimes images aren't being put on the screen the first time. This is one of my higher priorities to look into, but as there's every chance it's an issue within the library, I have decided to focus on stuff entirely within my control for now.
7. Add a bit of accessibility.
	Initially I was doing this purely for UI testing purposes, but actually I think it is a pretty important thing. One of the moments when I've had the most respect for Apple was when Tim Cook said "When we work on making our devices accessible by the blind, I don't consider the bloody ROI", and they really do put the work in, so I think it's right that I do too.
8. Be sloppy with Git.
	I have been more careful with my Repo repository, but in this one there are quite a few commits which do more that one logical thing. I haven't considered it worthwhile stashing these changes and commiting them on their own; I have prioritised feature development over this.
9. Not take any days off to do it.
	This has meant I have made a few 2 am commits, and while I have managed to stay off commitlogsfromlastnight.com, I'm pretty sure these haven't helped the overall code quality. There wasn't too much I could do about this, but still.
10. Stop before Easter weekend.
	I spent a few nights on this, as well as a couple of weekends, and while I would really like this position, I would also really like to spend Easter with my partner. So I hope that this is enough of a demonstration of my ability and care to get me in the door.
	
## Where I'd go from here

Well, apart from fixing all the stuff listed above, particularly the abstractions and the unsatisfactory level of testing.

1. Add an animation to the little bar that indicates which tab is selected.
	This would just give the app a little extra level of polish, and with a little better geometry being done on the paging scroll view, would give a better indication of which tab you would end up on if you were scrolling half way between the two.
2. Default to some kind of local persistence for Archived.
	There's not much reason to fetch super up to date values for the archived events. It'd save a bit of mobile data, battery and a lot of time for the end user.
3. More accessibility.
	Adjustable font sizes would be a really good feature for those with visual impairment (like my mum) who does use SpareRoom. I'm not _massively_ confident on how to do this, particularly while maintaining the look that you were going for with this one, but it's definitely a feature that benefits people.
4. Add a detail view.
	Obviously seeing more event details would be a pretty crucial feature for any continuation of this. Seeing who was going, being able to add a calendar event, maybe some push notifications - all that kind of stuff would make it a real finished product.


