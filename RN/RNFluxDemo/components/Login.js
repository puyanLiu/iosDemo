/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View
} from 'react-native';
import {
  Actions
} from 'react-native-router-flux';
import Button from "react-native-button";

class Login extends Component {
  render() {
    return (
      <View style={[styles.container, this.props.style]}>
        <Text style={styles.welcome}>
          Login page： {this.props.data}
        </Text>
        <Button onPress={Actions.loginModal2}>Login2</Button>
        <Button onPress={() => Actions.refresh({title: '哈哈标题被改变啦'})}>change title</Button>
        <Button onPress={Actions.pop}>back</Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  }
});

export default Login;
