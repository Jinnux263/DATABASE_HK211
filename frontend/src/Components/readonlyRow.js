import React from "react";

const readonlyRow = ({ course, handleEditClick, handleDeleteClick }) => {
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
        <button
          type="button"
          onClick={(event) => handleEditClick(event, course)}
        >
          Edit
        </button>
        <button
          type="button"
          onClick={() => handleDeleteClick(course.Course_ID)}
        >
          Delete
        </button>
      </td>
    </tr>
  );
};

export default readonlyRow;
