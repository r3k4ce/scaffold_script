import { render, screen } from "@testing-library/react";
import { afterEach, expect, test, vi } from "vitest";
import App from "./App";

afterEach(() => {
  vi.unstubAllGlobals();
});

test("renders backend health status", async () => {
  vi.stubGlobal(
    "fetch",
    vi.fn(async () => ({
      json: async () => ({ status: "ok", project: "demo" }),
    })) as unknown as typeof fetch,
  );

  render(<App />);

  expect(await screen.findByText("Backend: demo ok")).toBeInTheDocument();
});
