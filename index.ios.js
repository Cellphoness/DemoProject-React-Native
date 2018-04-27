// import React, {
//     Component,
// } from 'react';

// import {
//      AppRegistry,
//      Image,
//      StyleSheet,
//      Text,
//      View,
//      ListView,
//  } from 'react-native';



//  var REQUEST_URL = 'https://api.douban.com/v2/movie/top250';


//  class DemoProject extends Component
//  {
//      constructor(props) {
//          super(props);
//          this.state = {
//              dataSource: new ListView.DataSource({
//                  rowHasChanged: (row1, row2) => row1 !== row2,
//              }),
//              loaded: false,
//          };
//      }

//      componentDidMount(){
//          this.fetchData();
//      }

//      fetchData() {
//          fetch(REQUEST_URL)
//              .then((response) => response.json())
//              .then((responseData) => {
//                  this.setState({
//                      dataSource: this.state.dataSource.cloneWithRows(responseData.subjects),
//                      loaded: true,
//                  });
//              })
//              .done();
//      }

//      render() {
//          if (!this.state.loaded) {
//              return this.renderLoadingView();
//          }

//          return (
//              <ListView
//                  dataSource={this.state.dataSource}
//                  renderRow={this.renderMovie}
//                  style={styles.listView}
//              />
//          );
//      }

//      renderLoadingView()
//      {
//          return (<View style={styles.container} >
//                  <Text>Loading movies......</Text>
//              </View>

//          );
//      }

//      renderMovie(movie) {
//          return (
//              <View style={styles.container}>
//                  <Image
//                      source={{uri: movie.images.small}}
//                      style={styles.thumbnail}
//                  />
//                  <View style={styles.rightContainer}>
//                      <Text style={styles.title}>{movie.title}</Text>
//                      <Text style={styles.year}>{movie.year}</Text>
//                  </View>
//              </View>
//          );
//      }


//  };


//  var styles = StyleSheet.create({
//      container: {
//          flex: 1,
//          flexDirection: 'row',
//          justifyContent: 'center',
//          alignItems: 'center',
//          marginBottom: 10,
//          backgroundColor: '#F5FCFF',
//      },
//      rightContainer: {
//          flex: 1,
//      },
//      title: {
//          fontSize: 20,
//          marginBottom: 8,
//          textAlign: 'center',
//      },
//      year: {
//          textAlign: 'center',
//      },
//      thumbnail: {
//          width: 53,
//          height: 81,
//      },
//      listView: {
//          paddingTop: 0,
//          backgroundColor: '#F5FCFF',
//      },
//  });
//  AppRegistry.registerComponent('DemoProject', () => DemoProject);

// import 'react-devtools';//生产环境要注释
import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  ListView,
  Image,
  View,
  ActivityIndicator,
  TouchableOpacity,
  AlertIOS,
  NativeModules,
  findNodeHandle
} from 'react-native';
import {customView} from './customView'

var TestNativeManager = NativeModules.TestNativeManager;
var ViewManager = NativeModules.ViewManager;
var PresentationPop = NativeModules.PresentationPop;
const REQUEST_URL = 'https://api.douban.com/v2/movie/top250';

class ListViewCell extends Component {

  constructor(props) {
    super(props);
  }

  render() {
    let {data:{movie,rowID}} = this.props;
    let {data} = this.props;
    console.log(data);
    return (
      <TouchableOpacity style={styles.item} onPress={
        () => {
          if (this.props.handler) {
            this.props.handler(movie, rowID);
          }
        }
        }>
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
      </TouchableOpacity>
      );
  }
}

class DemoProject extends Component {

    constructor(){
        super();
        this.state = {
            movies:new ListView.DataSource({
                rowHasChanged:(row1,row2) => row1 !== row2
            }),
            loaded:false
        }
        this.cellRefs = {};
        this.fetchData();
    };

    popView() {
        PresentationPop.presentReactView({name:'CustomView', size:{width:200, height:200}, style:1});
    }

    clickHandler(data, rowID){

   //  	TestNativeManager.testFunction(this.state.movies).then((r)=>{
   //  		AlertIOS.alert(
  	// 			'Title',
  	// 			r,
  	// 			[
   //  				{text: 'OK', onPress: () => console.log('OK Pressed!')}
  	// 			]
			// )
   //  	}, (e)=>{

   //  	})

   		//1
        // this.refs.myTest.setNativeProps({
        // 	style:{
        // 		backgroundColor:'red'
        // 	}
        // })

        //2
        // this.myCell.setNativeProps({
        // 	style:{
        // 		backgroundColor:'red'
        // 	}
        // })

        //3
        //ReactDOM.findDOMNode(this.refs.refName)
      console.log(data);
      console.log(rowID);
      // console.log('this.refs');
      // console.log(this.refs);
      // console.log('cell');
      // console.log(this.cellRefs);//this.cellRefs[`cell${rowID}`]
   		ViewManager.viewWithReactTag(findNodeHandle(this.cellRefs[`cell${rowID}`])).then((r)=>{

    		AlertIOS.alert(
  				'Title',
  				r,
  				[
    				{text: 'OK', onPress: () => console.log('OK Pressed!')}
  				]
			)
    	}, (e)=>{

    	})
    }

    fetchData(){
        //拿取本地 没有本地缓存请求服务器
        TestNativeManager.getMovieData(100).then((responseData)=>{
            console.log(responseData);
	        this.setState({
	            movies:this.state.movies.cloneWithRows(responseData.subjects),
	            loaded:true
	        })
        }, (e)=>{
          fetch(REQUEST_URL)
            .then(response => response.json())
            .then(responseData => {
                console.log(responseData);
                this.setState({
                    movies:this.state.movies.cloneWithRows(responseData.subjects),
                    loaded:true
                })
                // 存数据
              TestNativeManager.testFunction(responseData).then((r)=>{
                AlertIOS.alert(
                  'Title',
                  'OK',
                  [
                    {text: 'OK', onPress: () => console.log('OK Pressed!')}
                  ]
                )
              })
            .done();

          }, (e)=>{

          });
        })
    };

    renderMovieList(movie, sectionID, rowID){
      return(
          <TouchableOpacity style={styles.item} onPress={
                	this.clickHandler.bind(this, movie, rowID)
                }>
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
          </TouchableOpacity>
      );
    }

    render() {
        if (!this.state.loaded) {
          return(
            <View style={styles.container}>
              <View style={styles.loading}>
                <ActivityIndicator ref='indicator' size='large' color='#eabb33'/>
              </View>
            </View>
            )
        }
        return (
         //ref={(e)=>{this.myCell = e}} 等价
         <View ref='myTest' style={styles.container}>
            <ListView ref='listView'
                dataSource={this.state.movies}
                renderRow={
                    //this.renderMovieList.bind(this)}
                    (data, sectionID, rowID) => <ListViewCell
                      ref={(cell)=>{
                        this.cellRefs[`cell${rowID}`]=cell;
                      }}
                      data={{movie:data, sectionID:sectionID, rowID:rowID}} handler={this.clickHandler.bind(this)}/>
                  }
                />
            <TouchableOpacity
            style={styles.button}
            onPress={this.popView}>
              <Text>
                Pop CustomView
              </Text>
           </TouchableOpacity>
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
    // padding:6 0 6 0,
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
  loading:{
    flex:1,
    justifyContent:'center',
    alignItems:'center',
  },
  button: {
    height: 50,
    justifyContent: 'center',
    alignItems: 'center',
    borderTopWidth: 1,
    borderTopColor: 'lightgray',
  }
});
AppRegistry.registerComponent('DemoProject', () => DemoProject);
AppRegistry.registerComponent('CustomView', () => customView);
