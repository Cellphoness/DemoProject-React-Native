import React, { Component } from 'react';
import {
  AppRegistry,
  View,
  Text,
  StyleSheet} from 'react-native';

const cView = () => (
  <View style={styles.custom}>
     <Text style={styles.text}>Center Title</Text>
  </View>
)

const styles = StyleSheet.create({
  custom: {
    flex: 1,
    padding: 100,
    backgroundColor: 'yellow',
  },
  text: {
    textAlign:'center',
    color: 'orange',
    fontSize: 28,
    letterSpacing: -0.5,
    marginTop: -15,
    fontWeight: '600',
  },
});

export default cView;
