/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  ListView,
  Image,
  View
} from 'react-native';

const REQUEST_URL = 'https://api.douban.com/v2/movie/top250';

class DemoProject extends Component {
    constructor(){
        super();
        this.state = {
            movies:new ListView.DataSource({
                rowHasChanged:(row1,row2) => row1 !== row2
            })
        }
        this.fetchData();
    };

    fetchData(){
        fetch(REQUEST_URL)
            .then(response => response.json())
            .then(responseData => {
                console.log(responseData);
                this.setState({
                    movies:this.state.movies.cloneWithRows(responseData.subjects)
                })
            })
            .done();
    };

    renderMovieList(movie){
      return(
          <View style={styles.item}>
            <View style={styles.itemImage}>
              <Image
                style={styles.image}
                source={{uri:movie.images.large}} />
            </View>
            <View style={styles.itemContent}>
              <Text style={styles.itemHeader}>
                {movie.title}
              </Text>
              <Text style={styles.itemMeta}>
                {movie.original_title} ({movie.year})
              </Text>
              <Text style={styles.redText}>
                {movie.rating.average}
              </Text>
            </View>
          </View>
      );
    }

    render() {
        return (
          <View style={styles.container}>
            <ListView
                dataSource={this.state.movies}
                renderRow={
                    this.renderMovieList.bind(this)}
                />
          </View>
        );
    }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
  },
  item:{
    flexDirection:'row',
    borderBottomWidth:1,
    borderColor:'rgba(100,53,201,0.1)',
    paddingBottom:6,
    paddingTop:6,
    flex:1,
  },
  itemText:{
    fontSize:16,
    fontFamily:'Helvetica Neue',
    fontWeight:'400',
    color:'rgba(0,0,0,0.8)',
    lineHeight:26,
  },
  image:{
    height:138,
    width:99,
    margin:6,
  },
  itemHeader:{
    fontSize:18,
    fontFamily:'Helvetica Neue',
    fontWeight:'300',
    color:'#6435c9',
    marginBottom:6,
  },
  itemContent:{
    flex:1,
    marginLeft:13,
    marginTop:6,
  },
  itemMeta:{
    fontSize:16,
    color:'rgba(0,0,0,0.6)',
    marginBottom:6,
  },
  redText:{
    color:'#db2828',
    fontSize:15,
  },
});

AppRegistry.registerComponent('DemoProject', () => DemoProject);
