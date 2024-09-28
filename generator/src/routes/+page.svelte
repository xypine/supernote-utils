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
			when: "Today",
			time: "14:00-15:30",
			where: "Madison Gardens",
			what: "Meet with Tom"
		},
		{
			when: "Tomorrow",
			time: "14:00",
			what: "The World Ends"
		},
		{
			when: "in a week",
			where: "Tom's Address",
			what: "Breakfast at Tom's"
		},
		{
			when: "in 2 weeks",
			where: "Tom's Address",
			what: "Breakfast at Tom's"
		},
		{
			when: "in 3 weeks",
			where: "Tom's Address",
			what: "Breakfast at Tom's"
		},
		{
			when: "in a month",
			where: "Tom's Address",
			what: "Breakfast at Tom's"
		},
		{
			when: "in a month",
			where: "Tom's Address",
			what: "Breakfast at Tom's\nwhile the world is on fire"
		},
	];
</script>
<main>
	<div id="top">
		<img id="brand" width="2048" height="1325" src="/ruta_software_white.png" alt="" />
	</div>
	<div id="center-container">
		<div id="center">
			<p>{date.toLocaleDateString("fi")}</p>
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

		display: grid;
		place-items: center;
		pointer-events: none;
	}
	#center {
		height: 10%;
		width: 100%;
		/*background: #FAFAFA;*/
		border: 1px solid transparent;
		border-block-color: #D0D0D0;

		display: grid;
		place-items: center;
		font-size: 88px;
		font-family: monospace, monospace;
	}

	#bottom {
		display: flex;
		justify-content: center;
		padding-top: calc(var(--sh) * 0.10);
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
