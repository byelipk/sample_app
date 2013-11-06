function cloud() {
    var word_array = [
      {text: "logic", weight: .5},
      {text: "rhetoric", weight: 2.5},
      {text: "nu", weight: 1.5},
      {text: "homework", weight: .5},
      {text: "foucoult", weight: 1.5}
    ];

    $('#example').jQCloud(word_array, {
		width: 500,
		height: 100,
		center: {x: 150, y: 50},
		shape: "rectangular",
		delayedMode: true,
		removeOverflowing: true
	});
}

//cloud();