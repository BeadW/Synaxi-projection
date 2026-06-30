from predictor.pipeline import PredictionPipeline


def test_prediction_pipeline_runs():
    pipeline = PredictionPipeline()
    result = pipeline.run({"payload": "sample input"})

    assert result["stage_status"][-1][1] == "success"
    assert result["output"]["verification"]["verified"] is True
