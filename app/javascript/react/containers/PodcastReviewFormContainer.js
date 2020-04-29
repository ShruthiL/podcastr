import React, { useState, useEffect } from "react";
import { Redirect } from "react-router-dom";
import _ from "lodash";

import ErrorList from "../components/ErrorList.js";

const PodcastReviewFormContainer = (props) => {
  const fields = ["rating", "review"];
  const [reviewRecord, setReviewRecord] = useState({
    rating: "",
    review: "",
  });
  const [newRecord, setNewRecord] = useState({});
  const [errors, setErrors] = useState({});

  const handleChange = (event) => {
    setReviewRecord({
      ...reviewRecord,
      [event.currentTarget.id]: event.currentTarget.value,
    });
  };

  const validForSubmission = () => {
    let submitErrors = {};
      if (reviewRecord["rating"].trim() === "") {
        submitErrors = {
          ...submitErrors,
          ["rating"]: "Rating is blank. Please submit a rating."
        };
      }

    setErrors(submitErrors);
    return _.isEmpty(submitErrors);
  };

  const onSubmit = (event) => {
    // event.preventDefault();
    // if (validForSubmission()) {
    //   let formPayload = {
    //     review: reviewRecord,
    //   };
    //   fetch("/api/v1/podcasts", {
    //     credentials: "same-origin",
    //     method: "POST",
    //     body: JSON.stringify(formPayload),
    //     headers: {
    //       Accept: "application/json",
    //       "Content-Type": "application/json",
    //     },
    //   })
    //     .then((response) => {
    //       if (response.ok) {
    //         return response;
    //       } else {
    //         response.json().then((body) => setErrors(body.error));
    //         let errorMessage = `${response.status} (${response.statusText})`;
    //         let error = new Error(errorMessage);
    //         throw error;
    //       }
    //     })
    //     .then((response) => response.json())
    //     .then((body) => {
    //       let newPodcast = body.podcast;
    //       setNewRecord(newPodcast);
    //       setShouldRedirect(true);
    //     })
    //     .catch((error) => console.error(`Error in fetch: ${error.message}`));
    // }
  };

//  re-render on submit if form is submitted successfully.

  return (
    <div>
      <ErrorList errors={errors} />
      <form className="new-review" onSubmit={onSubmit}>
        <label>
          Rating:
          <input
            type="text"
            id="rating"
            onChange={handleChange}
            value={reviewRecord.rating}
          />
        </label>

        <label>
          Review:
          <input
            type="text"
            id="review"
            onChange={handleChange}
            value={reviewRecord.review}
          />
        </label>

        <input className="button" type="submit" value="Submit" />
      </form>
    </div>
  );
};

export default PodcastReviewFormContainer;
