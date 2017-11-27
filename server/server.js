console.log('hello world', process.versions);

var runs = 0;
const timer = setInterval( () => {
	console.log('Wake', new Date());
	runs++;

	if (runs > 30) {
		clearInterval(timer);
	}
}, 1000);
