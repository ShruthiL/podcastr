import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import PodcastsIndexContainer from "../containers/PodcastsIndexContainer";

export const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/podcasts" component={PodcastsIndexContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  );
};

export default App;
