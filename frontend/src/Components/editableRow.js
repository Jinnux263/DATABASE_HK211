import React from "react";

const editableRow = ({ editData, handleEditData, handleCancelClick }) => {
  return (
    <tr>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter course id..."
          name="Course_ID"
          value={editData.Course_ID}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter course name..."
          name="Course_name"
          value={editData.Course_name}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter specialization..."
          name="SPECIALIZATION"
          value={editData.SPECIALIZATION}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter level..."
          name="Level"
          value={editData.Level}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter description..."
          name="Description"
          value={editData.Description}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter fee..."
          name="Fee"
          value={editData.Fee}
          onChange={handleEditData}
        />
      </td>
      <td>
        <input
          type="text"
          required="required"
          placeholder="Enter admin id..."
          name="Admin_ID"
          value={editData.Admin_ID}
          onChange={handleEditData}
        />
      </td>
      <td>
        <button type="submit">Save</button>
        <button type="button" onClick={handleCancelClick}>
          Cancel
        </button>
      </td>
    </tr>
  );
};

export default editableRow;
