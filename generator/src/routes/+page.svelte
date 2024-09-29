<script lang="ts">
	const date = new Date();
	type Event = {
		when: string;
		time?: string;
		where?: string;
		what: string;
	};
	const events: Event[] = [
		{
			when: "ASAP",
			where: "OLMONOKO",
			what: "Add API keys"
		},
		{
			when: "~2 weeks",
			where: "OLMONOKO",
			what: "Add sensitivity options"
		},
		{
			when: "Later",
			where: "OLMONOKO",
			what: "Add TODO support"
		},
	];
</script>
<main>
	<div id="top">
		<img id="brand" width="2048" height="1325" src="/ruta_software_white.png" alt="" />
	</div>
	<div id="center-container">
		<div id="center">
			<p>last updated <span id="last-updated">{date.toLocaleString("SV")}</span></p>
		</div>
	</div>
	<div id="bottom">
		<ul>
			{#each events as event}
			<li>
				<span class="when">
					{event.when}
					{#if event.time}
						<span class="time">{"\n"}{event.time}</span>
					{/if}
				</span>
				<span class="main-info">
					<span class="what">{event.what}</span>
					{#if event.where}
						<span class="where">{"\n@ "}{event.where}</span>
					{/if}
				</span>
			</li>
			{/each}
		</ul>
	</div>
</main>

<style>
	:global(*) {
		box-sizing: border-box;
		padding: 0;
		margin: 0;
		line-height: 1;
	}
	:global(body) {
		background: black;
		--sw: 1404px;
		--sh: 1872px;
	}
	ul {
		list-style: none;
	}
	main {
		width: var(--sw);
		height: var(--sh);
		background: white;
	}

	#top {
		display: grid;
		place-items: center;
		height: 50%;
	}
	img#brand {
		height: min(100%, 500px);
		width: auto;
		max-width: 100%;
		filter: invert(1);
	}

	#center-container {
		position: absolute;
		top: 0;
		left: 0;
		width: var(--sw);
		height: var(--sh);

	}
	#center {
		font-size: calc(38px * 0.5);
		font-family: monospace, monospace;
		color: #999;

		padding: 1ch;
		writing-mode: vertical-lr;
		rotate: -180deg;
		position: absolute;
		bottom: 0;
		right: 0;
	}
	#last-updated {
		color: #666;
	}

	#bottom {
		display: flex;
		justify-content: center;
		height: 50%;
		overflow-y: hidden;
		width: calc(var(--sw) * 0.75);
		margin-inline: auto;

		font-family: monospace, monospace;
		font-size: 38px;
		position: relative;
		
		&::before {
			content:'';
			width:100%;
			height:100%;    
			position:absolute;
			left:0;
			top:0;
			background:linear-gradient(transparent, transparent calc(var(--sh) * 0.10 + calc(var(--sh) * 0.33)), white);
			pointer-events: none;
		}
	}
	#bottom li {
		border-left: 1px solid #888;
		padding-left: 1ch;

		display: flex;
		gap: 1.5ch;

		& span {
			white-space: pre;
		}
	}
	#bottom ul {
		max-height: calc(var(--sh) * 0.3333);
		display: flex;
		flex-direction: column;
		gap: 2ch;
		/*width: 100%;*/
	}

	.when {
		width: 10ch;
	}
	.time, .where {
		font-size: 75%;
	}
</style>
