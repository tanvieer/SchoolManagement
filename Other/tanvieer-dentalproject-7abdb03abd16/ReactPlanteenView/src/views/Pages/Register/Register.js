import React, {Component} from "react";
import {Container, Row, Col, CardGroup, Card, CardBlock, CardFooter, Button, Input, InputGroup, InputGroupAddon} from "reactstrap";
import TextField from 'material-ui/TextField';
import RaisedButton from 'material-ui/RaisedButton';
import {white500, blue500, red500, grey300} from 'material-ui/styles/colors';
import ActionAndroid from 'material-ui/svg-icons/action/done';
import FontIcon from 'material-ui/FontIcon';
import DatePicker from 'material-ui/DatePicker';

const styles = {
  errorStyle: {
    color: red500,
  },
  underlineStyle: {
    borderColor: white500,
  },
  floatingLabelStyle: {
    color: white500,
    fontSize: 15,
  },
  floatingLabelFocusStyle: {
    color: white500,
    fontSize: 15,
  },
  hintStyle : {
    color: grey300,
  },
  registerButtonStyle: {
     marginTop: 20,
     textTransform: 'uppercase',
  },
  linkStyle: {
    textDecorationLine: 'underline',
    marginLeft: 10,
    fontSize: 13,
  },
  customBackgroundImage:{
    backgroundImage: 'url(../../img/registrationPageBackground.jpg)',
    backgroundSize: 'cover',
    overflow: 'hidden',
  },
};



class Register extends Component {
  render() {
    return (
      <div style={styles.customBackgroundImage} className="app flex-row align-items-center">
        <Container>
          <Row className="justify-content-center">
            <Col md="4">
              <Card className="mx-4 bg-primary">
                <CardBlock className="card-body p-4">
                  <h1>REGISTER</h1>
                  <p className="text-white">Create your account</p>
                  <TextField
                    floatingLabelText="FIRST NAME"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    underlineFocusStyle={styles.underlineStyle}
                    floatingLabelFixed={false}
                    errorStyle={styles.errorStyle}
                    type="text"
                  />
                  <TextField
                    floatingLabelText="LAST NAME"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    underlineFocusStyle={styles.underlineStyle}
                    floatingLabelFixed={false}
                    errorStyle={styles.errorStyle}
                    type="text"
                  />
                  <DatePicker
                    floatingLabelText="BIRTH DATE"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    underlineFocusStyle={styles.underlineStyle}
                    floatingLabelFixed={false}
                    errorStyle={styles.errorStyle}
                    openToYearSelection={true}
                  />
                  <TextField
                    floatingLabelText="EMAIL"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    underlineFocusStyle={styles.underlineStyle}
                    floatingLabelFixed={false}
                    errorStyle={styles.errorStyle}
                    type="email"
                  />
                  <TextField
                    floatingLabelText="PASSWORD"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    floatingLabelFixed={false}
                    underlineFocusStyle={styles.underlineStyle}
                    type="password"
                  />
                  <TextField
                    floatingLabelText="CONFIRM PASSWORD"
                    floatingLabelStyle={styles.floatingLabelStyle}
                    floatingLabelFocusStyle={styles.floatingLabelFocusStyle}
                    floatingLabelFixed={false}
                    underlineFocusStyle={styles.underlineStyle}
                    type="password"
                  />

                <RaisedButton
                  label="Create Account"
                  labelPosition="before"
                  primary={true}
                  icon={<ActionAndroid />}
                  fullWidth={true}
                  style={styles.registerButtonStyle}
                />

                </CardBlock>
                {/* <CardFooter className="p-4">
                  <Row>
                    <Col xs="12" sm="6">
                      <Button className="btn-facebook" block><span>facebook</span></Button>
                    </Col>
                    <Col xs="12" sm="6">
                      <Button className="btn-twitter" block><span>twitter</span></Button>
                    </Col>
                  </Row>
                </CardFooter> */}
              </Card>
            </Col>
          </Row>
        </Container>
      </div>
    );
  }
}

export default Register;
