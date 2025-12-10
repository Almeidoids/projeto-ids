function loadBlogs() {
	const section = document.getElementById("mainSection");

	for (let x = 0; x < 4; x++) {
		let article = document.createElement("article");
		article.className = "card";
		
		text = document.createElement("p");
		text.className = "date";
		text.textContent = "xx/xx/xxxx";
		
		let mainCard = document.createElement("main");
		
		let title = document.createElement("h1");
		title.className = "name";
		title.textContent = "Titulo";
		
		let description = document.createElement("p");
		description.className = "text";
		description.textContent = "Descrição";
		
		let footer = document.createElement("footer");
		footer.className = "algnActions";
		
		let button = document.createElement("button");
		button.className = "button";
		button.textContent = "Veja mais";
		
		mainCard.appendChild(title);
		mainCard.appendChild(description);
		
		
		footer.appendChild(button);
		
		article.appendChild(text);
		article.appendChild(mainCard);
		article.appendChild(footer);
		
		section.appendChild(article);
	}
}

document.addEventListener("DOMContentLoaded", loadBlogs);