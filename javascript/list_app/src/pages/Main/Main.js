import React, { Component } from "react";
import "./Main.css";

class Main extends Component {
	constructor(props) {
		super(props);
		this.state = {
			error: null,
			isLoaded: false,
			quotes: [],
			currentPage: 1,
			quotesPerPage: 15
		};
  this.handleClick = this.handleClick.bind(this);
 }
 handleClick(event) {
 	this.setState({
 		currentPage: Number(event.target.id)
 	});
 	console.log(this.state);
 }
  
  componentDidMount() {
    fetch("https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json")
      .then(res => {
        	return res.json()
        })
      .then(res => {
      		  console.log(res);
          this.setState({
          	isLoaded: true,
            quotes: res
          });
     
        }),
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
         

  }
  render() {
  	const { error, isLoaded, quotes, currentPage, quotesPerPage } = this.state;
  	const indexOfLastQuote = currentPage * quotesPerPage;
  	const indexOfFirstQuote = indexOfLastQuote - quotesPerPage;
  	const currentQuotes = this.state.quotes.slice(indexOfFirstQuote, indexOfLastQuote);
  	const renderQuotes = currentQuotes.map(quote => {
  		return <li key={quote.quote}>"{quote.quote}" by {quote.source} -- {quote.context} ({quote.theme})</li>;
  	});
  	const pageNumbers = [];
  	for (let i = 1; i <= Math.ceil(this.state.quotes.length / quotesPerPage); i++) {
  		pageNumbers.push(i);
  	}

  	const renderPageNumbers = pageNumbers.map(number => {
  		return (
  			<li
  			key={number}
  			id={number}
  			onClick={this.handleClick}
  			>
  			Page {number}
  			</li>
  			);
  	});

    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
      	<div>
      		<h1>Fun Quotes!</h1>
        <ul>
          {renderQuotes}
        </ul>
        <ul id="page-numbers">
              {renderPageNumbers}
            </ul>
        </div>
      );
    }
  }
}
export default Main;
