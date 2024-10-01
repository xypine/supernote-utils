import type { FetchFunction } from "vite"

export type APIRequestParams = {
	server_url?: string,
	api_key: string,
	fetch?: typeof fetch
}
export async function get_upcoming_events(params: APIRequestParams): Promise<OlmonokoEvent[]> {
	const server_url = params.server_url || "https://olmonoko.ruta.fi";
	const endpoint = `${server_url}/api/event/occurrences/planning_to_attend`;
	const f = params.fetch || fetch;

	try {
		const result = await f(endpoint, {
			headers: {
				"X-OLMONOKO-API-KEY": params.api_key
			}
		});
		if (!result.ok) {
			throw new Error(`endpoint returned non-ok status: ${result.status}`);
		}
		const events = await result.json() as OlmonokoEvent[];
		return events;
	} catch(e) {
		throw e;
	}
}

export type OlmonokoEvent = {
  id: number
  source: {
    type: string
    source_id?: number
    user_id?: number
  }
  priority: number
  tags: Array<string>
  attendance: {
    planned: boolean
    actual: boolean
    created_at: string
    updated_at: string
  }
  attendance_form: {
    attend_plan: string
    attend_actual: string
  }
  starts_at_human: string
  starts_at_seconds: number
  starts_at_utc: string
  overlap_total: number
  overlap_index: number
  all_day: boolean
  duration?: number
  duration_human?: string
  rrule: any
  from_rrule: boolean
  summary: string
  description?: string
  location?: string
  uid: string
};
