import React from "react";
import Enzyme, { mount } from "enzyme";
import Adapter from "enzyme-adapter-react-16";
Enzyme.configure({ adapter: new Adapter() });

import PodcastTile from "./PodcastTile";

describe("PodcastTile", () => {
  let wrapper;

  beforeEach(() => {
    wrapper = mount(
      <PodcastTile podcast={{ name: "Podcast1", url: "www.podcast.com" }} />
    );
  });

  it("should render an a element", () => {
    expect(wrapper.find("a")).toBeDefined();
  });

  it("should render an a element containing the text via props", () => {
    expect(wrapper.find("a").text()).toBe("Podcast1");
  });
});
