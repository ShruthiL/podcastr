import React from "react";

const ErrorList = (props) => {
  const errantFields = Object.keys(props.errors);

  if (errantFields.length > 0) {
    let index = 0;

    const errantFieldsArray = errantFields.map((field) => {
      index++;
      return <li key={index}>{props.errors[field]}</li>;
    });

    return (
      <div className="callout alert">
        <ul>{errantFieldsArray}</ul>
      </div>
    );
  } else {
    return "";
  }
};

export default ErrorList;
