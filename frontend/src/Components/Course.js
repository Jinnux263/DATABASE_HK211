import React from 'react'
import { Card } from 'react-bootstrap'
import { Link } from 'react-router-dom'
//import Rating from './Rating'

const Course = ({course}) => {
    return (
        <Card className='my-3 p-3 rounded'>
            <Link to={`/course/${course.Course_ID}`}>
                <Card.Img src={course.image} variant='top'/>
            </Link>
            <Card.Body>
                <Link to={`/course/${course.Course_ID}`}>
                    <Card.Title as='div'><strong>{course.Course_name}</strong></Card.Title>
                </Link>
                <Card.Text as='div'>
                    {/* <Rating
                        value={course.rating}
                        text={`${course.numReviews} reviews`}
                    /> */}
                    {course.SPECIALIZATION}
                    <br/>
                    {course.Description}
                </Card.Text>
                <Card.Text as='h3'>{course.Fee}</Card.Text>
            </Card.Body>
        </Card>
    )
}

export default Course
