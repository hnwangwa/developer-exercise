import React, { Component } from "react";

//I got as far as console logging the filtered quotes.
class FilterButtons extends Component {
	constructor(props){
		super(props)
		this.state = {
			isFiltered: false
		};
	}

	toggleMovieFilter = () => {
		this.setState({
			isFiltered: !this.state.isFiltered
			});
		var _ = require('lodash');
 		var quotes = this.props.quotes;
 		var filteredMovieQuotes = _.filter(quotes, {theme: "movies"});
 		console.log(filteredMovieQuotes);



	}
	toggleGameFilter = () => {
		this.setState({
			isFiltered: !this.state.isFiltered
			});
		var _ = require('lodash');
 		var quotes = this.props.quotes;
 		var filteredGameQuotes = _.filter(quotes, {theme: "games"});
 		console.log(filteredGameQuotes);

	}

	render () {
		return (
			<div>
				<ul>
					<button onClick={ () => this.toggleMovieFilter()}>Show me movie quotes!</button>

					<button onClick={ () => this.toggleGameFilter()}>Show me game quotes!</button>
				</ul>
			</div>
		);
	}
};


export default FilterButtons;