import React from "react";
import { Button } from "react-bootstrap";

const ReadonlyRow = ({ course, handleEditClick, handleDeleteClick }) => {
  return (
    <tr>
      <td>{course.Course_ID}</td>
      <td>{course.Course_name}</td>
      <td>{course.SPECIALIZATION}</td>
      <td>{course.Level}</td>
      <td>{course.Description}</td>
      <td>{course.Fee}</td>
      <td>{course.Admin_ID}</td>
      <td>
        <div className="text-center">
          <button
            type="button"
            class="btn btn-outline-primary btn-sm"
            onClick={(event) => handleEditClick(event, course)}
          >
            Edit
          </button>
        </div>
        <div className="mt-2 text-center">
          <button
            type="button"
            class="btn btn-outline-primary btn-sm"
            onClick={() => handleDeleteClick(course.Course_ID)}
          >
            Delete
          </button>
        </div>
      </td>
    </tr>
  );
};

export default ReadonlyRow;
