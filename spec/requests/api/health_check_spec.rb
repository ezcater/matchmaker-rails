RSpec.describe "Health Check" do
  describe "GET /api/health_check" do
    it "returns success" do
      get api_health_check_path

      health_check_ok_json = { status: :OK }.to_json
      expect(response).to be_successful
      expect(response.body).to eq(health_check_ok_json)
    end
  end
end
