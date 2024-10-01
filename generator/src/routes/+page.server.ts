import { env } from '$env/dynamic/private';
import { get_upcoming_events } from '$lib/olmonoko';
import type { PageLoad } from './$types';

export type Event = {
	when: string;
	time?: string;
	where?: string;
	what: string;
};

function truncate(text: string, maxlen: number, splitat?: string): string;
function truncate(text: undefined, maxlen: number, splitat?: string): undefined;
function truncate(text: string | undefined, maxlen: number, splitat?: string): string | undefined;

function truncate(text: string | undefined, maxlen: number, splitat?: string): string | undefined {
	if(text != undefined) {
		if(text.length <= maxlen) {
			return text;
		}
		const firstpart = text.split(splitat || ",")[0];
		let truncated = firstpart.slice(0, maxlen-1);
		if(truncated.length != firstpart.length) {
			truncated += "…"
		}
		return truncated;
	}
}

/**
 * Adapted from https://stackoverflow.com/a/67374710/
 */
const millisecondsPerSecond = 1000;
const secondsPerMinute = 60;
const minutesPerHour = 60;
const hoursPerDay = 24;
const daysPerWeek = 7;
const weeksPerMonth = 4;
const intervals = {
    'mo':      millisecondsPerSecond * secondsPerMinute * minutesPerHour * hoursPerDay * daysPerWeek * weeksPerMonth,
    'w':       millisecondsPerSecond * secondsPerMinute * minutesPerHour * hoursPerDay * daysPerWeek,
    'd':       millisecondsPerSecond * secondsPerMinute * minutesPerHour * hoursPerDay,
    'h':       millisecondsPerSecond * secondsPerMinute * minutesPerHour,
    'm':       millisecondsPerSecond * secondsPerMinute,
    's':       millisecondsPerSecond,
} as const;
const relativeDateFormat = new Intl.RelativeTimeFormat('en', { style: 'long' });

function formatRelativeTime(createTime: Date) {
    const diff = createTime.getTime() - (new Date()).getTime();
    for (const interval in intervals) {
        if (intervals[interval as keyof typeof intervals] <= Math.abs(diff)) {
            return `in ${Math.trunc(diff / intervals[interval as keyof typeof intervals])}·${interval}`;
        }
    }
    return relativeDateFormat.format(diff / 1000, 'second');
}

export const load: PageLoad = async ({ fetch }) => {
	const api_key = env.OLMONOKO_API_KEY;
	if(!api_key) {
		throw "OLMONOKO_API_KEY must be set!";
		
	}

	const date = new Date();
	const endpoint_events = await get_upcoming_events({
		api_key,
		fetch
        });
        const events: Event[] = [];
        for(const event of endpoint_events) {
            const starts_at = new Date(event.starts_at_utc);
            if(starts_at >= date) {
		const where = truncate(event.location, 30);
		const what = truncate(event.summary, 30);

		// TODO: Clean up
                events.push({
                    when: formatRelativeTime(starts_at),
                    time: `${event.starts_at_human.split(' ')[0].slice(5).replace('-', ".")}. ${event.starts_at_human.split(' ')[1]?.slice(0, 5) || ''}`,
		    where,
                    what
                });
            }
        }
	return {
		date,
		events
	};
};
