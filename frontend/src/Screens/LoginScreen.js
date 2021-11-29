import React, {useState} from 'react'
import { Form, Col, Row, Button } from 'react-bootstrap'
import FormContainer from '../Components/FormContainer'
import { Link } from 'react-router-dom'

const LoginScreen = ({location}) => {
    const [username, setUsername] = useState('')
    const [password, setPassword] = useState('')

    //const redirect = location.search ? location.search.split('=')[1] : '/'
    const submitHandler = (e) => {
        e.preventDefault()
    }
    return (
        <FormContainer>
            <h1>Sign in</h1>
            <Form onSubmit={submitHandler}>
                <Form.Group controllId='username' className='my-3'>
                    <Form.Label>Username</Form.Label>
                    <Form.Control type='text' placeholder='Enter username' value={username} onChange ={(e) => setUsername(e.target.value)}></Form.Control>
                </Form.Group>

                <Form.Group controllId='password' className='my-3'>
                    <Form.Label>Password</Form.Label>
                    <Form.Control type='password' placeholder='Enter password' value={password} onChange ={(e) => setPassword(e.target.value)}></Form.Control>
                </Form.Group>
                <Button type='submit' variant='primary'>
                    Sign in
                </Button>
            </Form>
            <Row className='py-3'>
                <Col>
                    New User?{' '}
                    <Link to={'/register'}>
                        Register
                    </Link>
                </Col>
            </Row>
        </FormContainer>
    )
}

export default LoginScreen
