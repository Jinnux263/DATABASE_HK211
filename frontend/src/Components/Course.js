import React from 'react'
import { Card } from 'react-bootstrap'
import Rating from './Rating'
import { Link } from 'react-router-dom'

const Course = ({course}) => {
    return (
        <Card className='my-3 p93 rounded'>
            <Link to={`/courses/${course._id}`}>
                <Card.Img src={course.image} variant='top'/>
            </Link>
            <Card.Body>
                <Link to={`/courses/${course._id}`}>
                    <Card.Title as='div'><strong>Title</strong></Card.Title>
                </Link>
                <Card.Text as='div'>
                    <Rating
                        value={course.rating}
                        text={`${course.numReviews} reviews`}
                    />
                </Card.Text>
                <Card.Text as='h3'>Additional description</Card.Text>
            </Card.Body>
        </Card>
    )
}

export default Course
