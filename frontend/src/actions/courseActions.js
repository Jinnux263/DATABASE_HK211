
import axios from 'axios'
import {
    COURSE_LIST_REQUEST,
    COURSE_LIST_SUCCESS,
    COURSE_LIST_FAIL,
    COURSE_DETAIL_SUCCESS,
    COURSE_DETAIL_REQUEST,
    COURSE_DETAIL_FAIL,
} from './../constant/courseConstant';


export const listCourses = () => async(dispatch) => {
    try {
        dispatch({type: COURSE_LIST_REQUEST})
        const { data } = await axios.get("api/courses");
        //console.log(data);
        dispatch({
            type: COURSE_LIST_SUCCESS,
            payload: data
        })
    } catch (error) {
        dispatch({
            type: COURSE_LIST_FAIL,
            payload: error.reponse && error.reponse.data.message
            ? error.reponse.data.message
            : error.message,
        })
    }
}

export const listCourseDetail = (id) => async(dispatch) => {
    try {
        dispatch({type: COURSE_DETAIL_REQUEST})
        const { data } = await axios.get(`/api/course/${id}`);
        //console.log(data);
        dispatch({
            type: COURSE_DETAIL_SUCCESS,
            payload: data
        })
    } catch (error) {
        dispatch({
            type: COURSE_DETAIL_FAIL,
            payload: error.reponse && error.reponse.data.message
            ? error.reponse.data.message
            : error.message,
        })
    }
}