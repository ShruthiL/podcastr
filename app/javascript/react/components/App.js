import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";

import PodcastsIndexContainer from "../containers/PodcastsIndexContainer";
import PodcastsNewContainer from "../containers/PodcastsNewContainer";

export const App = (props) => {
  return (
    <div>
      <BrowserRouter>
        <Switch>
          <Route exact path="/podcasts" component={PodcastsIndexContainer} />
          <Route exact path="/podcasts/new" component={PodcastsNewContainer} />
        </Switch>
      </BrowserRouter>
    </div>
  );
};

export default App;
